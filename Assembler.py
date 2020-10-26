import sys

class myClass():
  def method1(self):
    args = sys.argv[1:]
    RType = ['ADD', 'ADDU', 'ADDC', 'ADDCU', 'SUB', 'CMP', 'CMPU', 'AND', 'OR', 'XOR']
    Immediates = ['ADDI', 'ADDUI', 'ADDCI', 'ADDCUI', 'SUBI', 'CMPI', 'CMPUI', 'ANDI', 'ORI', 'XORI']
    Shift = ['LSH', 'RSH', 'ALSH', 'ARSH']
    ImmdShift = ['LSHI', 'RSHI', 'ALSHI', 'ARSHI']
    registers = ['%r0', '%r1', '%r2', '%r3', '%r4', '%r5', '%r6', '%r7', '%r8', '%r9', '%r10', '%r11', '%r12', '%r13', '%r14', '%r15']

    def ADD():
        return '0101'

    def ADDU():
        return '0110'

    def ADDC():
        return '0111'

    def ADDCU():
        return '0100'

    def ADDCUI():
        return '1010'

    def SUB():
        return '1001'

    def CMP():
        return '1011'

    def CMPU():
        return '1000'

    def CMPUI():
        return '1100'

    def AND():
        return '0001'

    def OR():
        return '0010'

    def XOR():
        return '0011'

    def LSH():
        return '0100'

    def LSHI():
        return '0000'

    def RSH():
        return '0101'

    def RSHI():
        return '0011'

    def ALSH():
        return '0110'

    def ALSHI():
        return '1000'

    def ARSH():
        return '0111'

    def ARSHI():
        return '1011'

    switcher = {
        'ADD': ADD,
        'ADDU': ADDU,
        'ADDC': ADDC,
        'ADDCU': ADDCU,
        'SUB': SUB,
        'CMP': CMP,
        'CMPU': CMPU,
        'AND': AND,
        'OR': OR,
        'XOR': XOR,
        'ADDI': ADD,
        'ADDUI': ADDU,
        'ADDCI': ADDC,
        'ADDCUI': ADDCUI,
        'SUBI': SUB,
        'CMPI': CMP,
        'CMPUI': CMPUI,
        'ANDI': AND,
        'ORI': OR,
        'XORI': XOR,
        'LSH': LSH,
        'LSHI': LSHI,
        'RSH': RSH,
        'RSHI': RSHI,
        'ALSH': ALSH,
        'ALSHI': ALSHI,
        'ARSH': ARSH,
        'ARSHI': ARSHI
    }

    def instrCode(name):
        func = switcher.get(name)
        return func()

    f = open(str(args[0]), 'r')
    out_name = str(args[1]) if len(args) >= 2 else str(args[0].rsplit('.', 1)[0] + '.b')
    wf = open(out_name, 'w')
    # f = open('program.txt', 'r')
    # wf = open('data_file.txt', 'w')

    for x in f:
        line = x.split('#')[0]
        parts = line.split()
        if (len(parts) > 0):
            instr = parts.pop(0)
            if (instr in RType):
                if (len(parts) == 2):
                    firstReg = parts.pop(0)
                    secondReg = parts.pop(0)
                    if ((firstReg in registers) and (secondReg in registers)):
                        firstRegNum = '{0:04b}'.format(int(firstReg.replace('%r', '')))
                        secondRegNum = '{0:04b}'.format(int(secondReg.replace('%r', '')))
                        data = '0000' + secondRegNum + instrCode(instr) + firstRegNum;
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: R-type needs two registers')
                else:
                    sys.exit('Syntax Error: R-type needs two args')
            elif (instr in Immediates):
                if (len(parts) == 2):
                    Immd = parts.pop(0)
                    secondReg = parts.pop(0)
                    if ((Immd[0] in '$') and (secondReg in registers)):
                        immediate = '{0:08b}'.format(int(Immd.replace('$', '')))
                        secondRegNum = '{0:04b}'.format(int(secondReg.replace('%r', '')))
                        data = instrCode(instr) + secondRegNum + immediate;
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: Immediate operations need an immd then a register')
                else:
                    sys.exit('Syntax Error: Immediate operations need two args')
            elif (instr in Shift):
               if (len(parts) == 2):
                    firstReg = parts.pop(0)
                    secondReg = parts.pop(0)
                    if ((firstReg in registers) and (secondReg in registers)):
                        firstRegNum = '{0:04b}'.format(int(firstReg.replace('%r', '')))
                        secondRegNum = '{0:04b}'.format(int(secondReg.replace('%r', '')))
                        data = '1000' + secondRegNum + instrCode(instr) + firstRegNum;
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: shifts needs two registers')
               else:
                   sys.exit('Syntax Error: shifts needs two args')
            elif (instr in ImmdShift):
                if (len(parts) == 2):
                    Immd = parts.pop(0)
                    secondReg = parts.pop(0)
                    if ((Immd[0] in '$') and (secondReg in registers)):
                        immediate = '{0:08b}'.format(int(Immd.replace('$', '')))
                        secondRegNum = '{0:04b}'.format(int(secondReg.replace('%r', '')))
                        data = '1000' + secondRegNum + instrCode(instr) + immediate[4:8];
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: Immediate shifts need an immd then a register')
                else:
                    sys.exit('Syntax Error: Immediate shifts need two args')
            elif (instr == 'NOT'):
                if (len(parts) == 1):
                    firstReg = parts.pop(0)
                    if ((firstReg in registers)):
                        firstRegNum = '{0:04b}'.format(int(firstReg.replace('%r', '')))
                        data = '0000' + firstRegNum + '11110000';
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: NOT operation needs one register')
                else:
                    sys.exit('Syntax Error: NOT operation needs one arg')
            elif (instr == 'LOAD'):
               if (len(parts) == 2):
                    firstReg = parts.pop(0)
                    secondReg = parts.pop(0)
                    if ((firstReg in registers) and (secondReg in registers)):
                        firstRegNum = '{0:04b}'.format(int(firstReg.replace('%r', '')))
                        secondRegNum = '{0:04b}'.format(int(secondReg.replace('%r', '')))
                        data = '0100' + firstRegNum + '0000' + secondRegNum;
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: load needs two registers')
               else:
                   sys.exit('Syntax Error: load needs two args')
            elif (instr == 'STOR'):
               if (len(parts) == 2):
                    firstReg = parts.pop(0)
                    secondReg = parts.pop(0)
                    if ((firstReg in registers) and (secondReg in registers)):
                        firstRegNum = '{0:04b}'.format(int(firstReg.replace('%r', '')))
                        secondRegNum = '{0:04b}'.format(int(secondReg.replace('%r', '')))
                        data = '0100' + firstRegNum + '0100' + secondRegNum;
                        wf.write(data + '\n')
                    else:
                        sys.exit('Syntax Error: store needs two registers')
               else:
                   sys.exit('Syntax Error: store needs two args')
            elif (instr == 'NOP'):
               if (len(parts) == 0):
                    data = '0000000000000000';
                    wf.write(data + '\n')
               else:
                   sys.exit('Syntax Error: load needs two args')
            else:
                sys.exit('Syntax Error: not a valid instruction')

    wf.close()
    f.close()

def main():
  c = myClass()
  c.method1()
  
if __name__ == "__main__":
  main()
