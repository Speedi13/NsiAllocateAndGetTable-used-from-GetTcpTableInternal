__int64 __fastcall GetTcpTableInternal(unsigned int *TcpTable, _DWORD *SizePointer, BOOL Order, unsigned int TcpInformationId, unsigned int TableId, BOOL bShowAllConnections)
{
  __int64 AddrEnryOffset; // r14
  BOOL v7; // ebx
  _DWORD *pSizePointer; // r12
  unsigned int *TableBase; // r15
  unsigned int EntryNbr; // esi
  __int64 result; // rax
  unsigned int ReturnCode; // edi
  unsigned int dwCount; // edx
  unsigned int v14; // er11
  signed int v15; // er8
  __int64 OwnerEntryOffset; // r13
  __int64 StateEntryOffset; // r9
  __int64 TableOut; // rbx
  size_t v19; // r10
  __int64 v20; // r10
  __int64 v21; // r11
  void *v22; // rax
  size_t SizeOfElementsToSort; // r10
  size_t NumberOfElementsToSort; // r11
  __int64 SizeOfAddrEntry; // [rsp+20h] [rbp-B8h]
  __int64 a7; // [rsp+30h] [rbp-A8h]
  __int64 SizeOfStateEntryMaby; // [rsp+40h] [rbp-98h]
  __int64 SizeOfOwnerEntry; // [rsp+50h] [rbp-88h]
  unsigned int Count; // [rsp+70h] [rbp-68h]
  unsigned int v30; // [rsp+74h] [rbp-64h]
  __int64 AddrEntry; // [rsp+78h] [rbp-60h]
  __int64 OwnerEntry; // [rsp+80h] [rbp-58h]
  __int64 StateEntry; // [rsp+88h] [rbp-50h]
  __int64 _StateEntryOffset; // [rsp+90h] [rbp-48h]
  signed int v35; // [rsp+E8h] [rbp+10h]
  BOOL bOrder; // [rsp+F0h] [rbp+18h]
                                                // TableId:
                                                //   0  => MIB_TCPROW
                                                //   1  => MIB_TCPTABLE2
                                                //   2  => MIB_TCPTABLE_OWNER_MODULE
                                                //   3  => MIB_TCPTABLE_OWNER_PID
  bOrder = Order;
  AddrEnryOffset = 0i64;
  v7 = Order;
  pSizePointer = SizePointer;
  TableBase = TcpTable;
  AddrEntry = 0i64;
  StateEntry = 0i64;
  OwnerEntry = 0i64;
  EntryNbr = 0;
  if ( !SizePointer )
    return 87i64;
  LODWORD(SizeOfOwnerEntry) = 0x20;
  LODWORD(SizeOfStateEntryMaby) = 0x10;
  LODWORD(a7) = 0;
  LODWORD(SizeOfAddrEntry) = 0x38;
  result = NsiAllocateAndGetTable_0(
             1i64,
             (__int64)&NPI_MS_TCP_MODULEID,
             TcpInformationId,
             (__int64)&AddrEntry,
             SizeOfAddrEntry,
             0i64,
             a7,
             (__int64)&StateEntry,
             SizeOfStateEntryMaby,
             (__int64)&OwnerEntry,
             SizeOfOwnerEntry,
             (__int64)&Count);                  // Size is zero so should not have a retun
  ReturnCode = result;
  if ( !(_DWORD)result )                        // check for error
  {
    if ( !TableBase )                           // check for invalid table base 
    {
      ReturnCode = 0x7A;                        // ERROR_INSUFFICIENT_BUFFER
      *pSizePointer = 0;
    }
    dwCount = Count;
    v14 = 0;
    v30 = 0;
    if ( Count > 0 )
    {
      v15 = 1;
      OwnerEntryOffset = 0i64;
      StateEntryOffset = 0i64;
      v35 = 1;
      _StateEntryOffset = 0i64;
      while ( 1 )
      {
        if ( *(_WORD *)(AddrEnryOffset + AddrEntry) != 2
          && (!bShowAllConnections || !*(_BYTE *)(OwnerEntryOffset + OwnerEntry + 3)) )
        {
          goto l_Skip;
        }
        if ( (unsigned __int64)(TcpRowSize[TableId] * v15) + 12 <= (unsigned int)*pSizePointer )
          break;
        ReturnCode = 0x7A;                      // ERROR_INSUFFICIENT_BUFFER
l_Loop:
        ++EntryNbr;
        v35 = ++v15;
l_Skip:
        ++v14;
        StateEntryOffset += 0x10i64;
        AddrEnryOffset += 0x38i64;
        OwnerEntryOffset += 0x20i64;
        v30 = v14;
        _StateEntryOffset = StateEntryOffset;
        if ( v14 >= dwCount )
        {
          v7 = bOrder;
          LODWORD(AddrEnryOffset) = 0;
          goto l_ExitLoop;
        }
      }
      TableOut = GetTcpRowFromTable((__int64)TableBase, EntryNbr, TableId);
      memset_0((void *)TableOut, 0, v19);
      StateEntryOffset = _StateEntryOffset;
      *(_DWORD *)TableOut = *(_DWORD *)(_StateEntryOffset + StateEntry);// TableOut.dwState
                                                // 
      if ( *(_WORD *)(AddrEnryOffset + AddrEntry) == 2 )// HasLocalAddress and RemoteAddress:
      {
        *(_DWORD *)(TableOut + 4) = *(_DWORD *)(AddrEnryOffset + AddrEntry + 4);// TableOut.dwLocalAddr
        *(_DWORD *)(TableOut + 8) = *(unsigned __int16 *)(AddrEnryOffset + AddrEntry + 2);// TableOut.dwLocalPort
        *(_DWORD *)(TableOut + 0xC) = *(_DWORD *)(AddrEnryOffset + AddrEntry + 0x20);// TableOut.dwRemoteAddr
      }
      else
      {                                         // Has no local and no remote address:
        *(_DWORD *)(TableOut + 4) = 0;          // TableOut.dwLocalAddr
        *(_QWORD *)(TableOut + 8) = *(unsigned __int16 *)(AddrEnryOffset + AddrEntry + 2);// TableOut.dwLocalPort
                                                //                                           TableOut.dwRemoteAddr = 0
                                                //                                           (this is a quad-word operation so it will zero dwRemoteAddr at + 0x0C too )
      }
      *(_DWORD *)(TableOut + 0x10) = *(unsigned __int16 *)(AddrEnryOffset + AddrEntry + 0x1E);// TableOut.dwRemotePort
      if ( TableId != 1 )
      {
        if ( TableId == 2 )
        {                                       // MIB_TCPTABLE_OWNER_MODULE:
          *(_DWORD *)(TableOut + 0x14) = *(_DWORD *)(OwnerEntryOffset + OwnerEntry + 0xC);// TableOut.dwOwningPid
          *(_QWORD *)(TableOut + 0x18) = *(_QWORD *)(OwnerEntryOffset + OwnerEntry + 0x10);// TableOut.liCreateTimestamp
          *(_QWORD *)(TableOut + 0x20) = *(_QWORD *)(OwnerEntryOffset + OwnerEntry + 0x18);// TableOut.OwningModuleInfo[0]
        }
        else if ( TableId == 3 )
        {                                       // MIB_TCPTABLE_OWNER_PID:
          goto LABEL_22;
        }
LABEL_23:
        v15 = v35;
        dwCount = Count;
        v14 = v30;
        goto l_Loop;
      }
      *(_DWORD *)(TableOut + 0x18) = *(_DWORD *)(StateEntryOffset + StateEntry + 8);// TableOut.dwOffloadState
LABEL_22:
      *(_DWORD *)(TableOut + 0x14) = *(_DWORD *)(OwnerEntryOffset + OwnerEntry + 0xC);// TableOut.dwOwningPid
      goto LABEL_23;
    }
l_ExitLoop:
    NsiFreeTable_0(AddrEntry, 0i64, StateEntry, OwnerEntry);
    if ( ReturnCode == 0x7A )                   // ERROR_INSUFFICIENT_BUFFER
    {
      *pSizePointer = (EntryNbr + 10) * TcpRowSize[TableId] + 0xC;
    }
    else
    {
      *TableBase = EntryNbr;                    // TableBase->dwNumEntries = EntryNbr
      *pSizePointer = EntryNbr * TcpRowSize[TableId] + 0xC;
      if ( v7 != (_DWORD)AddrEnryOffset )       // Resort the table
      {
        v20 = TcpRowSize[TableId];
        v21 = *TableBase;
        v22 = (void *)GetTcpRowFromTable((__int64)TableBase, 0, TableId);
        qsort(
          v22,
          NumberOfElementsToSort,               // r11d = EntryNbr
          SizeOfElementsToSort,                 // = pSizePointer = r10d, [r13+rbp*4+0] 
          (int (__cdecl *)(const void *, const void *))CompareMibTcpRow);
      }
    }
    result = ReturnCode;
  }
  return result;
}