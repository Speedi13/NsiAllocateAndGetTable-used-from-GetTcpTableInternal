# NsiAllocateAndGetTable-used-from-GetTcpTableInternal
Undocumented NsiAllocateAndGetTable usage in GetTcpTableInternal reverse engineered on Win7 X64 <br><br>
This might be useful for security researchers or other people who want to know how NsiAllocateAndGetTable is used since microsoft doesn't say anything about this function

# Reversed and commented disassemblies

IDA's Pseudocode <br>
- <a href="https://raw.githubusercontent.com/Speedi13/NsiAllocateAndGetTable-used-from-GetTcpTableInternal/master/GetTcpTableInternal_Pseudocode.gif">>>GetTcpTableInternal Pseudocode<<</a> 
- <a href="https://github.com/Speedi13/NsiAllocateAndGetTable-used-from-GetTcpTableInternal/blob/master/GetTcpTableInternal_Pseudocode.cpp">>>GetTcpTableInternal Pseudocode as cpp file<<</a> 

IDA's Assembly in graph view <br>
- <a href="https://raw.githubusercontent.com/Speedi13/NsiAllocateAndGetTable-used-from-GetTcpTableInternal/master/GetTcpTableInternal_assembly.gif">>>GetTcpTableInternal Assembly<<</a> 
- <a href="https://github.com/Speedi13/NsiAllocateAndGetTable-used-from-GetTcpTableInternal/blob/master/GetTcpTableInternal_Assembly.asm">>>GetTcpTableInternal Assembly as asm file<<</a> 

# Knowledge used to create a hook
- <a href="https://github.com/Speedi13/NsiAllocateAndGetTable-used-from-GetTcpTableInternal/blob/master/Hook.cpp">>>NsiAllocateAndGetTable hook in c++<<</a> 
