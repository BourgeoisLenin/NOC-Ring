

def int_to_bin(length, num):
    return format(num, '0'+str(length)+'b')

imem = []
dmem = []
expected_dmem = []
rf = []
fp1 = open("imem_1.fill","r")
fp2 = open("dmem.fill","r")
fp3 = open("reference_out.txt","w")
fp4 = open("expected_dmem_1.dump",'r')
read_imem = fp1.readlines()
read_dmem = fp2.readlines()
read_expected_dmem = fp4.readlines()
for each in read_imem:
    imem.append((each.strip()).split(" ") [0])
for each in read_dmem:
    dmem.append(int((each.strip()).split(" ") [0], base=16) )
for each in read_expected_dmem:
    dmem_single = (each.strip()).split(" ") [-1]
    expected_dmem.append(dmem_single )
for i in range(32):
    rf.append(0)

for pc in range(0,len(imem)):
    inst = bin(int(imem[pc],base=16)).replace("0b","")
    if(inst == '0'):
        break
    mode = inst[0:6]
    rd_index = int(inst[6:11],base=2)
    ra_index = int(inst[11:16],base=2)
    rb_index = int(inst[16:21],base=2)
    ra_data = rf[ra_index]
    rb_data = rf[rb_index]
    ppp = inst[21:24]
    ww = inst[24:26]
    op_code = inst[26:]
    imm_addr = int(inst[16:],base=2)
    rd_data = 0

    if mode == '100000':
        #VLD
        rd_data = dmem[imm_addr]
        rf[rd_index] = rd_data
    if mode == '100001':
        #VSD
        dmem[imm_addr] = rf[rd_index]

    if mode == '100010':
        #vbeq
        if rf[rd_index] == 0:
            pc = imm_addr
    if mode == '100011':
        #vbneq
        if rf[rd_index] != 0:
            pc = imm_addr
    if mode == '101010':
        if op_code == '000001':
            ## VAND
            if ww == '00':
                part = 8
            elif ww == '01':
                part = 16
            elif ww == '10':
                part = 32
            elif ww == '11':
                part = 64
            for i in range(int(64/part)):
                rd_data += ((ra_data>>((i)*part))%(2**part)& (rb_data>>((i)*part))%(2**part)) <<(i*part)
            rf[rd_index] = rd_data
            
        if op_code == '000010':
            #vor
            rd_data = ra_data | rd_data
            rf[rd_index] = rd_data
        if op_code == '000011':
            rd_data = ra_data ^ rb_data
            rf[rd_index] = rd_data
        if op_code == '000100':
            ##VNOT
            ra_data= 32
            ra_string = format(ra_data, '0'+str(64)+'b')
            rd_string = ''
            print(ra_string)
            for i in range (len(ra_string)):
                if(ra_string[i] == '1'):
                    rd_string += '0'
                if ra_string[i] == '0':
                    rd_string += '1'
            rd_data =int(rd_string,base=2)
            rf[rd_index] = rd_data
        if op_code == '000101':
            #vmov 
            rd_data = ra_data
            rf[rd_index] = rd_data
        if op_code == '000110':
            #vadd
            if ww == '00':
                part = 8
            elif ww == '01':
                part = 16
            elif ww == '10':
                part = 32
            elif ww == '11':
                part = 64
            for i in range(int(64/part)):      
                rd_data += (((ra_data>>((i)*part))%(2**part) + (rb_data>>((i)*part))%(2**part)))%(2**part) <<(i*part)
            rf[rd_index] = rd_data
        if op_code == '001111':
            #vmod
            if ww == '00':
                part = 8
            elif ww == '01':
                part = 16
            elif ww == '10':
                part = 32
            elif ww == '11':
                part = 64
            ra_data = 257
            rb_data = 511
            for i in range(int(64/part)):      
                rd_data += ( (((ra_data>>((i)*part))%(2**part)) % ((rb_data>>((i)*part))%(2**part)))%(2**part)) <<(i*part)
            rf[rd_index] = rd_data
    rf[0] = 0

for i in range(0,len(dmem)):
    fp3.writelines(hex(dmem[i]).replace("0x","") +"\n")

#compare result
error_count = 0
for i in range(0,len(dmem)):
    if(int(expected_dmem[i],base=16) != dmem[i]):
        print("ERROR, location "+str(i)+". Expected: "+expected_dmem[i]+". Got: "+hex(dmem[i]).replace("0x","")+".")
        error_count += 1
if(error_count == 0):
    print("All tests passed. DUT memory dump equals reference memory dump.")
