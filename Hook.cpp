
//for NPI_MODULEID look at https://msdn.microsoft.com/en-us/library/windows/hardware/ff568813(v=vs.85).aspx

typedef __int64 (*t_NsiAllocateAndGetTable)(
    __int64 a1, struct NPI_MODULEID* a2, unsigned int a3, void *a4, int a5, void *a6, int a7, void *a8, __int64 a9, void *a10, int a11, DWORD *a12
);  

BYTE NPI_MS_TCP_MODULEID[] = { 0x18, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x03, 0x4A, 0x00, 0xEB, 0x1A, 0x9B, 0xD4, 0x11, 0x91, 0x23, 0x00, 0x50, 0x04, 0x77, 0x59, 0x0BC };

t_NsiAllocateAndGetTable oNsiAllocateAndGetTable = NULL;
__int64 __fastcall hkNsiAllocateAndGetTable(__int64 a1, 
												struct NPI_MODULEID* NPI_MS_ID, 
												unsigned int TcpInformationId, 
												void *pAddrEntry, 
												int SizeOfAddrEntry, 
												void *a6, int a7, 
												void *pStateEntry, 
												int SizeOfStateEntry,
												void *pOwnerEntry, 
												int SizeOfOwnerEntry, 
												DWORD *Count)
{
	__int64 result = oNsiAllocateAndGetTable( a1, NPI_MS_ID, TcpInformationId, pAddrEntry, SizeOfAddrEntry, a6, a7, pStateEntry, SizeOfStateEntry, pOwnerEntry, SizeOfOwnerEntry, Count );
	
	//based on reversed data from GetTcpTableInternal
	if ( memcmp( NPI_MS_ID, NPI_MS_TCP_MODULEID, 24 ) == NULL && result == NULL && *(DWORD*)Count > 0 )
	{
		DWORD64 StateEntryOffset = NULL;
		DWORD64 AddrEnryOffset = NULL;
		DWORD64 OwnerEntryOffset = NULL;

		DWORD dwNumEntries = 1;

		for (DWORD i = 0; i < *(DWORD*)Count; i++, 
													StateEntryOffset += 0x10,
													AddrEnryOffset += 0x38,
													OwnerEntryOffset += 0x20 )
		{
			DWORD64 AddrEnry = (DWORD64)( *(DWORD64*)pAddrEntry + AddrEnryOffset );
			DWORD64 StateEntry = (DWORD64)( *(DWORD64*)pStateEntry + StateEntryOffset );
			DWORD64 OwnerEntry = (DWORD64)( *(DWORD64*)pOwnerEntry + OwnerEntryOffset );

			//maby not sure if named correctly:
			BOOL bShowAllConnections = TRUE;

			if ( *(WORD *)(AddrEnry + 0x00) != 2 && (!bShowAllConnections || !*(BYTE *)(OwnerEntry + 0x03) ) )
				continue;

			dwNumEntries++;

			WORD dwState = *(WORD*)( StateEntry );
			DWORD dwOffloadState = *(DWORD*)( StateEntry + 0x08 );

			printf("[%u] State = %u || %u\n",i,dwState,*(WORD*)( AddrEnry ));

			DWORD LocalAddr = *(DWORD*)( AddrEnry + 0x04 );

			WORD LocalPort = ntohs((*(WORD*)( AddrEnry + 0x02 )));
			printf("[%u] LocalPort = %u\n",i,LocalPort);

			DWORD RemoteAddr = *(DWORD*)( AddrEnry + 0x20 );

			WORD RemotePort = ntohs((*(WORD*)( AddrEnry + 0x1E )));
			printf("[%u] RemotePort = %u\n",i,RemotePort);

			DWORD dwOwningPid = *(DWORD*)( OwnerEntry + 0x0C );
			printf("[%u] dwOwningPid = %u\n",i,dwOwningPid);

			LARGE_INTEGER liCreateTimestamp = *(LARGE_INTEGER*)( OwnerEntry + 0x10 );
			ULONGLONG OwningModuleInfo = *(ULONGLONG*)( OwnerEntry + 0x18 );
		}

		printf("dwNumEntries = %u\n",dwNumEntries);
	}
	return result;
}

//credits for this function to: 
//  https://stackoverflow.com/questions/15573504/getextendedtcptable-donesnt-return-the-same-result-as-netstat-ano
std::string GetListOfTcpPorts()
{
    std::string ApplicationName = "";
    std::string result = "";
    std::string aux = "";
    std::string RemotePort = "";
    typedef DWORD (WINAPI *t_pGetExtendedTcpTable)(
    PVOID pTcpTable,
    PDWORD pdwSize,
    BOOL bOrder,
    ULONG ulAf,
    TCP_TABLE_CLASS TableClass,
    ULONG Reserved
    );
    
    MIB_TCPTABLE_OWNER_PID *pTCPInfo;
    MIB_TCPROW_OWNER_PID *owner;
    DWORD size;
    DWORD dwResult;


    HMODULE hLib = LoadLibrary("iphlpapi.dll");

    t_pGetExtendedTcpTable pGetExtendedTcpTable = (t_pGetExtendedTcpTable)
        GetProcAddress(hLib, "GetExtendedTcpTable");

    dwResult = pGetExtendedTcpTable(NULL,       &size, false, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0);
    pTCPInfo = (MIB_TCPTABLE_OWNER_PID*)malloc(size);
    dwResult = pGetExtendedTcpTable(pTCPInfo,   &size, false, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0);       

	
   for (DWORD dwLoop = 0; dwLoop < pTCPInfo->dwNumEntries; dwLoop++)
    {
        owner = &pTCPInfo->table[dwLoop];      
        ApplicationName = std::to_string(owner->dwOwningPid);
        std::string OpenedPort = std::to_string(ntohs(owner->dwLocalPort));         
        std::string RemotePort = std::to_string(ntohs(owner->dwRemotePort));
        aux = "TCP ; dwLocalPort [" + OpenedPort + "]; RemotePort["+ RemotePort+"];PID["+ ApplicationName + "]\n";
        result = result + aux;

    }
    return result;
}

int main()
{
  HMODULE hNsi = LoadLibraryA( "nsi.dll" );
	void* FncNsiAllocateAndGetTable = GetProcAddress( hNsi, "NsiAllocateAndGetTable" );
  
  //Hook the function
	oNsiAllocateAndGetTable = (t_NsiAllocateAndGetTable)DetourTrampoline( FncNsiAllocateAndGetTable, &hkNsiAllocateAndGetTable );

  //Call the higher level api to trigger the hook:
  MessageBoxA(0,GetListOfTcpPorts().c_str(),"GetListOfTcpPorts",0);
	return 0;
}
