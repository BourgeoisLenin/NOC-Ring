
fp1 = open("assembly1.txt","r")
fp2 = open("hex1.txt","w")  
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

        ## ppp = 0, set ww
        if(word[0][len(word[0])-1] == 'b'):
            binary_output.append( '00000')
        if(word[0][len(word[0])-1] == 'h'):
            binary_output.append( '00001')
        if(word[0][len(word[0])-1] == 'w'):
            binary_output.append( '00010')
        if(word[0][len(word[0])-1] == 'd'):
            binary_output.append( '00011')
        
        ## opcode
        if('VAND' in word[0]):
            binary_output.append('000001')
        if('VOR'  in word[0]):
            binary_output.append('000010')
        if('VXOR'  in word[0]):
            binary_output.append('000011')
        if('VADD' in word[0]):
            binary_output.append('000110')
        if('VSUB' in word[0]):
            binary_output.append('000111')
        if('VMULEU' in word[0]):
            binary_output.append('001000')
        if('VMULOU' in word[0]):
            binary_output.append('001001')
        if('VSLL' in word[0]):
            binary_output.append('001010')
        if('VSRL' in word[0]):
            binary_output.append('001011')
        if('VSRA' in word[0]):
            binary_output.append('001100')
        if('VDIV' in word[0]):
            binary_output.append('001110')
        if('VMOD' in word[0]):
            binary_output.append('001111')
        if('VSQEU' in word[0]):
            binary_output.append('010000')
        if('VSQOU' in word[0]):
            binary_output.append('010001')
        if('VSQRT' in word[0]):
            binary_output.append('010010')    
        
    elif len(word) == 3:
            ## VNOT VMOV VRTTH, M type, Branch
        if "VLD" in word[0]:
            binary_output.append("100000")
        elif "VSD" in word[0]:
            binary_output.append("100001")
        elif "VBEZ" in word[0]:
            binary_output.append("100010")
        elif "VBNEZ" in word[0]:
            binary_output.append("100011")
        elif "VLD" in word[0]:
            binary_output.append("100000")
        else:
           binary_output.append("101010")
        

        binary_output.append( int_to_bin(5, int(word[1][1:]))) ##rd
        
        if ('VNOT' in word[0]) | ('VMOV' in word[0]) | ('VRTTH' in word[0]):
            
            binary_output.append( int_to_bin(5, int(word[2][1:]))) ##ra
            binary_output.append( '00000')
            if(word[0][len(word[0])-1] == 'b'):
                binary_output.append( '00000')
            if(word[0][len(word[0])-1] == 'h'):
                binary_output.append( '00001')
            if(word[0][len(word[0])-1] == 'w'):
                binary_output.append( '00010')
            if(word[0][len(word[0])-1] == 'd'):
                binary_output.append( '00011')
            if('VNOT' in word[0]):
                binary_output.append('000100')
            if('VMOV' in word[0]):
                binary_output.append('000101')
            if('VRTTH' in word[0]):
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
    fp2.writelines(hex(int(flat_out,2)).replace("0x","") +"\n")
print(binary_output_list)