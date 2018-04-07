.text:000007FF718A104C
.text:000007FF718A104C ; =============== S U B R O U T I N E =======================================
.text:000007FF718A104C
.text:000007FF718A104C
.text:000007FF718A104C ; __int64 __fastcall GetTcpTableInternal(unsigned int *TcpTable, _DWORD *SizePointer, BOOL Order, unsigned int TcpInformationId, unsigned int TableId, BOOL bShowAllConnections)
.text:000007FF718A104C GetTcpTableInternal proc near           ; CODE XREF: GetTcpTableV4+14?p
.text:000007FF718A104C                                         ; GetTcpTable+17?p ...
.text:000007FF718A104C
.text:000007FF718A104C SizeOfAddrEntry = qword ptr -0B8h
.text:000007FF718A104C a6              = qword ptr -0B0h
.text:000007FF718A104C a7              = qword ptr -0A8h
.text:000007FF718A104C a8              = qword ptr -0A0h
.text:000007FF718A104C SizeOfStateEntryMaby= qword ptr -98h
.text:000007FF718A104C a10             = qword ptr -90h
.text:000007FF718A104C SizeOfOwnerEntry= qword ptr -88h
.text:000007FF718A104C a12             = qword ptr -80h
.text:000007FF718A104C UnknownTableSize= qword ptr -78h
.text:000007FF718A104C Count           = dword ptr -68h
.text:000007FF718A104C anonymous_0     = dword ptr -64h
.text:000007FF718A104C AddrEntry       = qword ptr -60h
.text:000007FF718A104C OwnerEntry      = qword ptr -58h
.text:000007FF718A104C StateEntry      = qword ptr -50h
.text:000007FF718A104C _StateEntryOffset= qword ptr -48h
.text:000007FF718A104C arg_0           = qword ptr  8
.text:000007FF718A104C arg_8           = dword ptr  10h
.text:000007FF718A104C bOrder          = dword ptr  18h
.text:000007FF718A104C TableId         = dword ptr  28h
.text:000007FF718A104C bShowAllConnections= dword ptr  30h
.text:000007FF718A104C
.text:000007FF718A104C                 mov     r11, rsp
.text:000007FF718A104F                 mov     [r11+8], rbx
.text:000007FF718A1053                 mov     [r11+18h], r8d
.text:000007FF718A1057                 push    rbp
.text:000007FF718A1058                 push    rsi
.text:000007FF718A1059                 push    rdi
.text:000007FF718A105A                 push    r12
.text:000007FF718A105C                 push    r13
.text:000007FF718A105E                 push    r14
.text:000007FF718A1060                 push    r15
.text:000007FF718A1062                 sub     rsp, 0A0h
.text:000007FF718A1069                 xor     r14d, r14d
.text:000007FF718A106C                 mov     eax, r9d
.text:000007FF718A106F                 mov     ebx, r8d
.text:000007FF718A1072                 mov     r12, rdx
.text:000007FF718A1075                 mov     r15, rcx
.text:000007FF718A1078                 mov     [r11-60h], r14
.text:000007FF718A107C                 mov     [r11-50h], r14
.text:000007FF718A1080                 mov     [r11-58h], r14
.text:000007FF718A1084                 mov     esi, r14d
.text:000007FF718A1087                 cmp     rdx, r14
.text:000007FF718A108A                 jnz     short loc_7FF718A1095
.text:000007FF718A108C                 lea     eax, [r14+57h]
.text:000007FF718A1090                 jmp     loc_7FF718A1367
.text:000007FF718A1095 ; ---------------------------------------------------------------------------
.text:000007FF718A1095
.text:000007FF718A1095 loc_7FF718A1095:                        ; CODE XREF: GetTcpTableInternal+3E?j
.text:000007FF718A1095                 mov     byte ptr [rsp+0D8h+UnknownTableSize], r14b ; a13
.text:000007FF718A109A                 lea     rcx, [rsp+0D8h+Count]
.text:000007FF718A109F                 lea     r9, [rsp+0D8h+AddrEntry] ; a4
.text:000007FF718A10A4                 mov     [rsp+0D8h+a12], rcx ; a12
.text:000007FF718A10A9                 mov     dword ptr [rsp+0D8h+SizeOfOwnerEntry], 20h ; SizeOfOwnerEntry
.text:000007FF718A10B1                 lea     rcx, [rsp+0D8h+OwnerEntry]
.text:000007FF718A10B9                 mov     [rsp+0D8h+a10], rcx ; a10
.text:000007FF718A10BE                 mov     dword ptr [rsp+0D8h+SizeOfStateEntryMaby], 10h ; SizeOfStateEntryMaby
.text:000007FF718A10C6                 lea     rcx, [rsp+0D8h+StateEntry]
.text:000007FF718A10CE                 mov     [rsp+0D8h+a8], rcx ; a8
.text:000007FF718A10D3                 mov     dword ptr [rsp+0D8h+a7], r14d ; rsp+0x30
.text:000007FF718A10D8                 lea     rdx, NPI_MS_TCP_MODULEID ; TypePtr
.text:000007FF718A10DF                 mov     ecx, 1          ; a1
.text:000007FF718A10E4                 mov     r8d, eax        ; a3
.text:000007FF718A10E7                 mov     [rsp+0D8h+a6], r14 ; rsp+0x28
.text:000007FF718A10EC                 mov     dword ptr [rsp+0D8h+SizeOfAddrEntry], 38h ; rsp+0x20
.text:000007FF718A10F4                 call    NsiAllocateAndGetTable_0
.text:000007FF718A10F9                 mov     edi, eax
.text:000007FF718A10FB                 cmp     eax, r14d       ; Did return error
.text:000007FF718A10FE                 jnz     loc_7FF718A1367 ; jump if error
.text:000007FF718A1104                 cmp     r15, r14        ; check table base ptr for zero
.text:000007FF718A1107                 jnz     short loc_7FF718A1112
.text:000007FF718A1109                 mov     edi, 7Ah        ; ERROR_INSUFFICIENT_BUFFER
.text:000007FF718A110E                 mov     [r12], r14d
.text:000007FF718A1112
.text:000007FF718A1112 loc_7FF718A1112:                        ; CODE XREF: GetTcpTableInternal+BB?j
.text:000007FF718A1112                 mov     edx, [rsp+0D8h+Count]
.text:000007FF718A1116                 movsxd  rbp, [rsp+0D8h+TableId]
.text:000007FF718A111E                 mov     r11d, r14d
.text:000007FF718A1121                 mov     [rsp+0D8h+anonymous_0], r14d
.text:000007FF718A1126                 lea     r13, TcpRowSize
.text:000007FF718A112D                 cmp     edx, r14d
.text:000007FF718A1130                 jbe     loc_7FF718A12EE
.text:000007FF718A1136                 mov     r8d, 1
.text:000007FF718A113C                 mov     r13, r14
.text:000007FF718A113F                 mov     r9, r14
.text:000007FF718A1142                 mov     [rsp+0D8h+arg_8], r8d
.text:000007FF718A114A                 mov     [rsp+0D8h+_StateEntryOffset], r14
.text:000007FF718A1152
.text:000007FF718A1152 loc_7FF718A1152:                        ; CODE XREF: GetTcpTableInternal+28B?j
.text:000007FF718A1152                 mov     rax, [rsp+0D8h+AddrEntry]
.text:000007FF718A1157                 cmp     word ptr [r14+rax], 2
.text:000007FF718A115D                 jz      short loc_7FF718A1181
.text:000007FF718A115F                 cmp     [rsp+0D8h+bShowAllConnections], 0
.text:000007FF718A1167                 jz      loc_7FF718A12B8
.text:000007FF718A116D                 mov     rax, [rsp+0D8h+OwnerEntry]
.text:000007FF718A1175                 cmp     byte ptr [r13+rax+3], 0
.text:000007FF718A117B                 jz      loc_7FF718A12B8
.text:000007FF718A1181
.text:000007FF718A1181 loc_7FF718A1181:                        ; CODE XREF: GetTcpTableInternal+111?j
.text:000007FF718A1181                 mov     eax, [r12]
.text:000007FF718A1185                 lea     rcx, TcpRowSize
.text:000007FF718A118C                 mov     r10d, [rcx+rbp*4]
.text:000007FF718A1190                 mov     ecx, r8d
.text:000007FF718A1193                 imul    ecx, r10d
.text:000007FF718A1197                 add     rcx, 0Ch
.text:000007FF718A119B                 cmp     rcx, rax
.text:000007FF718A119E                 jbe     short loc_7FF718A11AA
.text:000007FF718A11A0                 mov     edi, 7Ah        ; ERROR_INSUFFICIENT_BUFFER
.text:000007FF718A11A5                 jmp     loc_7FF718A12AB
.text:000007FF718A11AA ; ---------------------------------------------------------------------------
.text:000007FF718A11AA
.text:000007FF718A11AA loc_7FF718A11AA:                        ; CODE XREF: GetTcpTableInternal+152?j
.text:000007FF718A11AA                 mov     r8d, ebp        ; TableNbr
.text:000007FF718A11AD                 mov     edx, esi        ; EntryNbr
.text:000007FF718A11AF                 mov     rcx, r15        ; TableBase
.text:000007FF718A11B2                 call    GetTcpRowFromTable
.text:000007FF718A11B7                 mov     r8, r10         ; Size
.text:000007FF718A11BA                 xor     edx, edx        ; Val
.text:000007FF718A11BC                 mov     rcx, rax        ; Dst
.text:000007FF718A11BF                 mov     rbx, rax
.text:000007FF718A11C2                 call    memset_0
.text:000007FF718A11C7                 mov     r11, [rsp+0D8h+StateEntry]
.text:000007FF718A11CF                 mov     r9, [rsp+0D8h+_StateEntryOffset]
.text:000007FF718A11D7                 mov     ecx, [r9+r11]
.text:000007FF718A11DB                 mov     [rbx], ecx
.text:000007FF718A11DD                 mov     rax, [rsp+0D8h+AddrEntry]
.text:000007FF718A11E2                 cmp     word ptr [r14+rax], 2
.text:000007FF718A11E8                 jnz     short loc_7FF718A120F
.text:000007FF718A11EA                 mov     ecx, [r14+rax+4]
.text:000007FF718A11EF                 mov     [rbx+4], ecx
.text:000007FF718A11F2                 mov     rax, [rsp+0D8h+AddrEntry]
.text:000007FF718A11F7                 movzx   ecx, word ptr [r14+rax+2]
.text:000007FF718A11FD                 mov     [rbx+8], ecx
.text:000007FF718A1200                 mov     rax, [rsp+0D8h+AddrEntry]
.text:000007FF718A1205                 mov     ecx, [r14+rax+20h]
.text:000007FF718A120A                 mov     [rbx+0Ch], ecx
.text:000007FF718A120D                 jmp     short loc_7FF718A1225
.text:000007FF718A120F ; ---------------------------------------------------------------------------
.text:000007FF718A120F
.text:000007FF718A120F loc_7FF718A120F:                        ; CODE XREF: GetTcpTableInternal+19C?j
.text:000007FF718A120F                 and     dword ptr [rbx+4], 0
.text:000007FF718A1213                 mov     rax, [rsp+0D8h+AddrEntry]
.text:000007FF718A1218                 movzx   ecx, word ptr [r14+rax+2]
.text:000007FF718A121E                 and     dword ptr [rbx+0Ch], 0
.text:000007FF718A1222                 mov     [rbx+8], ecx
.text:000007FF718A1225
.text:000007FF718A1225 loc_7FF718A1225:                        ; CODE XREF: GetTcpTableInternal+1C1?j
.text:000007FF718A1225                 mov     rax, [rsp+0D8h+AddrEntry]
.text:000007FF718A122A                 movzx   ecx, word ptr [r14+rax+1Eh]
.text:000007FF718A1230                 mov     [rbx+10h], ecx
.text:000007FF718A1233                 mov     ecx, ebp
.text:000007FF718A1235                 sub     ecx, 1
.text:000007FF718A1238                 jz      short loc_7FF718A127A
.text:000007FF718A123A                 sub     ecx, 1
.text:000007FF718A123D                 jz      short loc_7FF718A1246
.text:000007FF718A123F                 cmp     ecx, 1
.text:000007FF718A1242                 jnz     short loc_7FF718A129A
.text:000007FF718A1244                 jmp     short loc_7FF718A128A
.text:000007FF718A1246 ; ---------------------------------------------------------------------------
.text:000007FF718A1246
.text:000007FF718A1246 loc_7FF718A1246:                        ; CODE XREF: GetTcpTableInternal+1F1?j
.text:000007FF718A1246                 mov     rax, [rsp+0D8h+OwnerEntry]
.text:000007FF718A124E                 mov     ecx, [r13+rax+0Ch]
.text:000007FF718A1253                 mov     [rbx+14h], ecx
.text:000007FF718A1256                 mov     rax, [rsp+0D8h+OwnerEntry]
.text:000007FF718A125E                 mov     rcx, [r13+rax+10h]
.text:000007FF718A1263                 mov     [rbx+18h], rcx
.text:000007FF718A1267                 mov     rax, [rsp+0D8h+OwnerEntry]
.text:000007FF718A126F                 mov     rcx, [r13+rax+18h]
.text:000007FF718A1274                 mov     [rbx+20h], rcx
.text:000007FF718A1278                 jmp     short loc_7FF718A129A
.text:000007FF718A127A ; ---------------------------------------------------------------------------
.text:000007FF718A127A
.text:000007FF718A127A loc_7FF718A127A:                        ; CODE XREF: GetTcpTableInternal+1EC?j
.text:000007FF718A127A                 mov     rax, [rsp+0D8h+StateEntry]
.text:000007FF718A1282                 mov     ecx, [r9+rax+8]
.text:000007FF718A1287                 mov     [rbx+18h], ecx
.text:000007FF718A128A
.text:000007FF718A128A loc_7FF718A128A:                        ; CODE XREF: GetTcpTableInternal+1F8?j
.text:000007FF718A128A                 mov     rax, [rsp+0D8h+OwnerEntry]
.text:000007FF718A1292                 mov     ecx, [r13+rax+0Ch]
.text:000007FF718A1297                 mov     [rbx+14h], ecx
.text:000007FF718A129A
.text:000007FF718A129A loc_7FF718A129A:                        ; CODE XREF: GetTcpTableInternal+1F6?j
.text:000007FF718A129A                                         ; GetTcpTableInternal+22C?j
.text:000007FF718A129A                 mov     r8d, [rsp+0D8h+arg_8]
.text:000007FF718A12A2                 mov     edx, [rsp+0D8h+Count]
.text:000007FF718A12A6                 mov     r11d, [rsp+0D8h+anonymous_0]
.text:000007FF718A12AB
.text:000007FF718A12AB loc_7FF718A12AB:                        ; CODE XREF: GetTcpTableInternal+159?j
.text:000007FF718A12AB                 inc     esi
.text:000007FF718A12AD                 inc     r8d
.text:000007FF718A12B0                 mov     [rsp+0D8h+arg_8], r8d
.text:000007FF718A12B8
.text:000007FF718A12B8 loc_7FF718A12B8:                        ; CODE XREF: GetTcpTableInternal+11B?j
.text:000007FF718A12B8                                         ; GetTcpTableInternal+12F?j
.text:000007FF718A12B8                 inc     r11d
.text:000007FF718A12BB                 add     r9, 10h
.text:000007FF718A12BF                 add     r14, 38h
.text:000007FF718A12C3                 add     r13, 20h
.text:000007FF718A12C7                 mov     [rsp+0D8h+anonymous_0], r11d
.text:000007FF718A12CC                 mov     [rsp+0D8h+_StateEntryOffset], r9
.text:000007FF718A12D4                 cmp     r11d, edx
.text:000007FF718A12D7                 jb      loc_7FF718A1152
.text:000007FF718A12DD                 mov     ebx, [rsp+0D8h+bOrder]
.text:000007FF718A12E4                 xor     r14d, r14d
.text:000007FF718A12E7                 lea     r13, TcpRowSize
.text:000007FF718A12EE
.text:000007FF718A12EE loc_7FF718A12EE:                        ; CODE XREF: GetTcpTableInternal+E4?j
.text:000007FF718A12EE                 mov     r9, [rsp+0D8h+OwnerEntry]
.text:000007FF718A12F6                 mov     r8, [rsp+0D8h+StateEntry]
.text:000007FF718A12FE                 mov     rcx, [rsp+0D8h+AddrEntry]
.text:000007FF718A1303                 xor     edx, edx
.text:000007FF718A1305                 call    NsiFreeTable_0
.text:000007FF718A130A                 cmp     edi, 7Ah        ; ERROR_INSUFFICIENT_BUFFER
.text:000007FF718A130D                 jnz     short loc_7FF718A1323
.text:000007FF718A130F                 mov     edx, [r13+rbp*4+0]
.text:000007FF718A1314                 lea     eax, [rsi+0Ah]
.text:000007FF718A1317                 imul    edx, eax
.text:000007FF718A131A                 add     edx, 0Ch
.text:000007FF718A131D                 mov     [r12], edx
.text:000007FF718A1321                 jmp     short loc_7FF718A1365
.text:000007FF718A1323 ; ---------------------------------------------------------------------------
.text:000007FF718A1323
.text:000007FF718A1323 loc_7FF718A1323:                        ; CODE XREF: GetTcpTableInternal+2C1?j
.text:000007FF718A1323                 mov     [r15], esi
.text:000007FF718A1326                 mov     eax, [r13+rbp*4+0]
.text:000007FF718A132B                 imul    eax, esi
.text:000007FF718A132E                 add     eax, 0Ch
.text:000007FF718A1331                 mov     [r12], eax
.text:000007FF718A1335                 cmp     ebx, r14d
.text:000007FF718A1338                 jz      short loc_7FF718A1365
.text:000007FF718A133A                 mov     r10d, [r13+rbp*4+0]
.text:000007FF718A133F                 mov     r11d, [r15]
.text:000007FF718A1342                 mov     r8d, ebp        ; TableNbr
.text:000007FF718A1345                 xor     edx, edx        ; EntryNbr
.text:000007FF718A1347                 mov     rcx, r15        ; TableBase
.text:000007FF718A134A                 call    GetTcpRowFromTable
.text:000007FF718A134F                 lea     r9, CompareMibTcpRow ; PtFuncCompare
.text:000007FF718A1356                 mov     r8, r10         ; SizeOfElements
.text:000007FF718A1359                 mov     rcx, rax        ; Base
.text:000007FF718A135C                 mov     rdx, r11        ; NumOfElements
.text:000007FF718A135F                 call    cs:__imp_qsort
.text:000007FF718A1365
.text:000007FF718A1365 loc_7FF718A1365:                        ; CODE XREF: GetTcpTableInternal+2D5?j
.text:000007FF718A1365                                         ; GetTcpTableInternal+2EC?j
.text:000007FF718A1365                 mov     eax, edi
.text:000007FF718A1367
.text:000007FF718A1367 loc_7FF718A1367:                        ; CODE XREF: GetTcpTableInternal+44?j
.text:000007FF718A1367                                         ; GetTcpTableInternal+B2?j
.text:000007FF718A1367                 mov     rbx, [rsp+0D8h+arg_0]
.text:000007FF718A136F                 add     rsp, 0A0h
.text:000007FF718A1376                 pop     r15
.text:000007FF718A1378                 pop     r14
.text:000007FF718A137A                 pop     r13
.text:000007FF718A137C                 pop     r12
.text:000007FF718A137E                 pop     rdi
.text:000007FF718A137F                 pop     rsi
.text:000007FF718A1380                 pop     rbp
.text:000007FF718A1381                 retn
.text:000007FF718A1381 ; ---------------------------------------------------------------------------
.text:000007FF718A1382                 align 8
.text:000007FF718A1382 GetTcpTableInternal endp
.text:000007FF718A1382