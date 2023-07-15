# RUN: llvm-mc -triple=ve --show-encoding < %s \
# RUN:     | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: llvm-mc -triple=ve -filetype=obj < %s | llvm-objdump -d - \
# RUN:     | FileCheck %s --check-prefixes=CHECK-INST

# CHECK-INST: ld %s11, 8199
# CHECK-ENCODING: encoding: [0x07,0x20,0x00,0x00,0x00,0x00,0x0b,0x01]
ld %s11, 8199

# CHECK-INST: ld %s11, 20(%s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x00,0x8b,0x0b,0x01]
ld %s11, 20(%s11)

# CHECK-INST: ld %s11, -1(, %s11)
# CHECK-ENCODING: encoding: [0xff,0xff,0xff,0xff,0x8b,0x00,0x0b,0x01]
ld %s11, -1(, %s11)

# CHECK-INST: ld %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x0b,0x01]
ld %s11, 20(%s10, %s11)

# CHECK-INST: ldu %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x0b,0x02]
ldu %s11, 20(%s10, %s11)

# CHECK-INST: ldl.sx %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x0b,0x03]
ldl.sx %s11, 20(%s10, %s11)

# CHECK-INST: ldl.zx %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x8b,0x03]
ldl.zx %s11, 20(%s10, %s11)

# CHECK-INST: ld2b.sx %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x0b,0x04]
ld2b.sx %s11, 20(%s10, %s11)

# CHECK-INST: ld2b.zx %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x8b,0x04]
ld2b.zx %s11, 20(%s10, %s11)

# CHECK-INST: ld1b.sx %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x0b,0x05]
ld1b.sx %s11, 20(%s10, %s11)

# CHECK-INST: ld1b.zx %s11, 20(%s10, %s11)
# CHECK-ENCODING: encoding: [0x14,0x00,0x00,0x00,0x8b,0x8a,0x8b,0x05]
ld1b.zx %s11, 20(%s10, %s11)