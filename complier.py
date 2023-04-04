
fp1 = open("assembly1.txt","r")
fp2 = open("binary1.txt","w")
inst = fp1.readlines()
binary_output_list = []
hex_output_list = []

def int_to_bin(length, num):
    return format(num, '0'+str(length)+'b')

for line in inst:
    word = (line.strip()).split(" ")
    binary_output = []
    ##print(word)
    ##print(len(word))
    ## first 6 bit
    if len(word)==4:
        ##r type excluding VNOT VMOV VRTTH
        binary_output.append("101010")
        binary_output.append( int_to_bin(5, int(word[1][1:]))) ##rd
        binary_output.append( int_to_bin(5, int(word[2][1:]))) ##ra
        binary_output.append( int_to_bin(5, int(word[3][1:]))) ##rb
        binary_output.append( '00000') ## ppp + ww
        ## opcode
        if(word[0] == 'VAND'):
            binary_output.append('000001')
        if(word[0] == 'VOR'):
            binary_output.append('000010')
        if(word[0] == 'VXOR'):
            binary_output.append('000011')
        if(word[0] == 'VADD'):
            binary_output.append('000001')
        if(word[0] == 'VSUB'):
            binary_output.append('000111')
        if(word[0] == 'VMULEU'):
            binary_output.append('001000')
        if(word[0] == 'VMULOU'):
            binary_output.append('001001')
        if(word[0] == 'VSLL'):
            binary_output.append('001010')
        if(word[0] == 'VSRL'):
            binary_output.append('001011')
        if(word[0] == 'VSRA'):
            binary_output.append('001100')
        if(word[0] == 'VDIV'):
            binary_output.append('001110')
        if(word[0] == 'VMOD'):
            binary_output.append('001111')
        if(word[0] == 'VSQEU'):
            binary_output.append('010000')
        if(word[0] == 'VSQOU'):
            binary_output.append('010001')
        if(word[0] == 'VSQRT'):
            binary_output.append('010010')    
        
    elif len(word) == 3:
            ## VNOT VMOV VRTTH, M type, Branch
        if word[0] == "VLD":
            binary_output.append("100000")
        elif word[0] == "VSD":
            binary_output.append("100001")
        elif word[0] == "VBEZ":
            binary_output.append("100010")
        elif word[0] == "VBNEZ":
            binary_output.append("100011")
        elif word[0] == "VLD":
            binary_output.append("100000")
        else:
           binary_output.append("101010")
        

        binary_output.append( int_to_bin(5, int(word[1][1:]))) ##rd
        
        if (word[0] == 'VNOT') | (word[0] == 'VMOV') | (word[0] == 'VRTTH'):
            
            binary_output.append( int_to_bin(5, int(word[2][1:]))) ##ra
            binary_output.append( '00000')
            binary_output.append( '00000')
            if(word[0] == 'VNOT'):
                binary_output.append('000100')
            if(word[0] == 'VMOV'):
                binary_output.append('000101')
            if(word[0] == 'VRTTH'):
                binary_output.append('001101')
        else:
            binary_output.append( '00000')
            binary_output.append( int_to_bin(16,int(word[2])))

    else:
        binary_output.append("11110000000000000000000000000000")

    ##
    binary_output_list.append(binary_output)

for output in binary_output_list:
    flat_out = ''
    for field in output:
        flat_out= flat_out+field
    print(  hex(int(flat_out,2)).replace("0x","")   )
print(binary_output_list)