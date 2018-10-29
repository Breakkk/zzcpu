/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//vmware-host/Shared Folders/Desktop/zzcpu/CPU/Controller.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {0U, 0U};
static int ng3[] = {15, 0};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {8U, 0U};
static unsigned int ng6[] = {2U, 0U};
static unsigned int ng7[] = {9U, 0U};



static void Cont_51_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 5496U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 4096);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 6408);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 65535U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 15);
    t18 = (t0 + 6312);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Initial_56_1(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(56, ng0);

LAB2:    xsi_set_current_line(57, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 3776);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 18);
    xsi_set_current_line(58, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 3616);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 18);

LAB1:    return;
}

static void Always_61_2(char *t0)
{
    char t4[8];
    char t22[8];
    char t23[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    int t21;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    int t28;
    char *t29;
    int t30;
    int t31;
    char *t32;
    int t33;
    int t34;
    int t35;
    int t36;
    int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    char *t45;
    char *t46;

LAB0:    t1 = (t0 + 5992U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 6328);
    *((int *)t2) = 1;
    t3 = (t0 + 6024);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(61, ng0);

LAB5:    xsi_set_current_line(62, ng0);
    t5 = (t0 + 1776U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t5) == 0)
        goto LAB6;

LAB8:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB9:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(65, ng0);

LAB14:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 3456);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB15:    t6 = ((char*)((ng2)));
    t21 = xsi_vlog_unsigned_case_compare(t5, 2, t6, 2);
    if (t21 == 1)
        goto LAB16;

LAB17:    t2 = ((char*)((ng4)));
    t21 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t21 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng6)));
    t21 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t21 == 1)
        goto LAB20;

LAB21:
LAB22:
LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(62, ng0);

LAB13:    xsi_set_current_line(63, ng0);
    t19 = ((char*)((ng2)));
    t20 = (t0 + 3456);
    xsi_vlogvar_assign_value(t20, t19, 0, 0, 2);
    xsi_set_current_line(64, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4256);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    goto LAB12;

LAB16:    xsi_set_current_line(67, ng0);

LAB23:    xsi_set_current_line(68, ng0);
    t12 = (t0 + 1456U);
    t13 = *((char **)t12);
    t12 = (t0 + 3616);
    t19 = (t0 + 3616);
    t20 = (t19 + 72U);
    t24 = *((char **)t20);
    t25 = ((char*)((ng3)));
    t26 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t4, t22, t23, ((int*)(t24)), 2, t25, 32, 1, t26, 32, 1);
    t27 = (t4 + 4);
    t7 = *((unsigned int *)t27);
    t28 = (!(t7));
    t29 = (t22 + 4);
    t8 = *((unsigned int *)t29);
    t30 = (!(t8));
    t31 = (t28 && t30);
    t32 = (t23 + 4);
    t9 = *((unsigned int *)t32);
    t33 = (!(t9));
    t34 = (t31 && t33);
    if (t34 == 1)
        goto LAB24;

LAB25:    xsi_set_current_line(69, ng0);
    t2 = (t0 + 1456U);
    t3 = *((char **)t2);
    t2 = (t0 + 3776);
    t6 = (t0 + 3776);
    t12 = (t6 + 72U);
    t13 = *((char **)t12);
    t19 = ((char*)((ng3)));
    t20 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t4, t22, t23, ((int*)(t13)), 2, t19, 32, 1, t20, 32, 1);
    t24 = (t4 + 4);
    t7 = *((unsigned int *)t24);
    t21 = (!(t7));
    t25 = (t22 + 4);
    t8 = *((unsigned int *)t25);
    t28 = (!(t8));
    t30 = (t21 && t28);
    t26 = (t23 + 4);
    t9 = *((unsigned int *)t26);
    t31 = (!(t9));
    t33 = (t30 && t31);
    if (t33 == 1)
        goto LAB26;

LAB27:    xsi_set_current_line(70, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3456);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 2);
    xsi_set_current_line(71, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4576);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 3616);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    memset(t4, 0, 8);
    t12 = (t4 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t13);
    t10 = (t9 >> 0);
    *((unsigned int *)t12) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 65535U);
    t14 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t14 & 65535U);
    t19 = (t0 + 4096);
    xsi_vlogvar_assign_value(t19, t4, 0, 0, 16);
    goto LAB22;

LAB18:    xsi_set_current_line(75, ng0);

LAB28:    xsi_set_current_line(76, ng0);
    t3 = (t0 + 1456U);
    t6 = *((char **)t3);
    t3 = (t0 + 3936);
    xsi_vlogvar_assign_value(t3, t6, 0, 0, 16);
    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 4576);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 5800);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB29;
    goto LAB1;

LAB20:    xsi_set_current_line(92, ng0);

LAB47:    xsi_set_current_line(93, ng0);
    t3 = ((char*)((ng4)));
    t6 = (t0 + 4576);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 1);
    xsi_set_current_line(94, ng0);
    t2 = (t0 + 5800);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB48;
    goto LAB1;

LAB24:    t10 = *((unsigned int *)t23);
    t35 = (t10 + 0);
    t11 = *((unsigned int *)t4);
    t14 = *((unsigned int *)t22);
    t36 = (t11 - t14);
    t37 = (t36 + 1);
    xsi_vlogvar_assign_value(t12, t13, t35, *((unsigned int *)t22), t37);
    goto LAB25;

LAB26:    t10 = *((unsigned int *)t23);
    t34 = (t10 + 0);
    t11 = *((unsigned int *)t4);
    t14 = *((unsigned int *)t22);
    t35 = (t11 - t14);
    t36 = (t35 + 1);
    xsi_vlogvar_assign_value(t2, t3, t34, *((unsigned int *)t22), t36);
    goto LAB27;

LAB29:    xsi_set_current_line(78, ng0);
    t3 = ((char*)((ng2)));
    t6 = (t0 + 4576);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 1);
    xsi_set_current_line(79, ng0);
    t2 = (t0 + 3936);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    memset(t22, 0, 8);
    t12 = (t22 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (t7 >> 0);
    *((unsigned int *)t22) = t8;
    t9 = *((unsigned int *)t13);
    t10 = (t9 >> 0);
    *((unsigned int *)t12) = t10;
    t11 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t11 & 255U);
    t14 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t14 & 255U);
    t19 = (t0 + 3776);
    t20 = (t19 + 56U);
    t24 = *((char **)t20);
    memset(t23, 0, 8);
    t25 = (t23 + 4);
    t26 = (t24 + 4);
    t15 = *((unsigned int *)t24);
    t16 = (t15 >> 0);
    *((unsigned int *)t23) = t16;
    t17 = *((unsigned int *)t26);
    t18 = (t17 >> 0);
    *((unsigned int *)t25) = t18;
    t38 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t38 & 255U);
    t39 = *((unsigned int *)t25);
    *((unsigned int *)t25) = (t39 & 255U);
    xsi_vlogtype_concat(t4, 16, 16, 2U, t23, 8, t22, 8);
    t27 = (t0 + 4096);
    xsi_vlogvar_assign_value(t27, t4, 0, 0, 16);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 4256);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng5)));
    memset(t4, 0, 8);
    t13 = (t6 + 4);
    t19 = (t12 + 4);
    t7 = *((unsigned int *)t6);
    t8 = *((unsigned int *)t12);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t13);
    t11 = *((unsigned int *)t19);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t19);
    t18 = (t16 | t17);
    t38 = (~(t18));
    t39 = (t15 & t38);
    if (t39 != 0)
        goto LAB33;

LAB30:    if (t18 != 0)
        goto LAB32;

LAB31:    *((unsigned int *)t4) = 1;

LAB33:    t24 = (t4 + 4);
    t40 = *((unsigned int *)t24);
    t41 = (~(t40));
    t42 = *((unsigned int *)t4);
    t43 = (t42 & t41);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB34;

LAB35:    xsi_set_current_line(85, ng0);

LAB38:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = (t0 + 3616);
    t13 = (t12 + 56U);
    t19 = *((char **)t13);
    memset(t4, 0, 8);
    t20 = (t6 + 4);
    t24 = (t19 + 4);
    t7 = *((unsigned int *)t6);
    t8 = *((unsigned int *)t19);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t20);
    t11 = *((unsigned int *)t24);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t20);
    t17 = *((unsigned int *)t24);
    t18 = (t16 | t17);
    t38 = (~(t18));
    t39 = (t15 & t38);
    if (t39 != 0)
        goto LAB40;

LAB39:    if (t18 != 0)
        goto LAB41;

LAB42:    t26 = (t4 + 4);
    t40 = *((unsigned int *)t26);
    t41 = (~(t40));
    t42 = *((unsigned int *)t4);
    t43 = (t42 & t41);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB43;

LAB44:
LAB45:    xsi_set_current_line(89, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 18, t6, 18, t12, 18);
    t13 = (t0 + 3776);
    xsi_vlogvar_assign_value(t13, t4, 0, 0, 18);

LAB36:    goto LAB22;

LAB32:    t20 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB33;

LAB34:    xsi_set_current_line(80, ng0);

LAB37:    xsi_set_current_line(81, ng0);
    t25 = ((char*)((ng6)));
    t26 = (t0 + 3456);
    xsi_vlogvar_assign_value(t26, t25, 0, 0, 2);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 3616);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = (t0 + 3776);
    xsi_vlogvar_assign_value(t12, t6, 0, 0, 18);
    xsi_set_current_line(83, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4256);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    xsi_set_current_line(84, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 4416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB36;

LAB40:    *((unsigned int *)t4) = 1;
    goto LAB42;

LAB41:    t25 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB42;

LAB43:    xsi_set_current_line(86, ng0);

LAB46:    xsi_set_current_line(87, ng0);
    t27 = (t0 + 4256);
    t29 = (t27 + 56U);
    t32 = *((char **)t29);
    t45 = ((char*)((ng4)));
    memset(t22, 0, 8);
    xsi_vlog_unsigned_add(t22, 4, t32, 4, t45, 4);
    t46 = (t0 + 4256);
    xsi_vlogvar_assign_value(t46, t22, 0, 0, 4);
    goto LAB45;

LAB48:    xsi_set_current_line(94, ng0);
    t3 = ((char*)((ng2)));
    t6 = (t0 + 4576);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 1);
    xsi_set_current_line(95, ng0);
    t2 = (t0 + 4256);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng7)));
    memset(t4, 0, 8);
    t13 = (t6 + 4);
    t19 = (t12 + 4);
    t7 = *((unsigned int *)t6);
    t8 = *((unsigned int *)t12);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t13);
    t11 = *((unsigned int *)t19);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t19);
    t18 = (t16 | t17);
    t38 = (~(t18));
    t39 = (t15 & t38);
    if (t39 != 0)
        goto LAB52;

LAB49:    if (t18 != 0)
        goto LAB51;

LAB50:    *((unsigned int *)t4) = 1;

LAB52:    t24 = (t4 + 4);
    t40 = *((unsigned int *)t24);
    t41 = (~(t40));
    t42 = *((unsigned int *)t4);
    t43 = (t42 & t41);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB53;

LAB54:    xsi_set_current_line(98, ng0);

LAB57:    xsi_set_current_line(99, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 18, t6, 18, t12, 18);
    t13 = (t0 + 3776);
    xsi_vlogvar_assign_value(t13, t4, 0, 0, 18);
    xsi_set_current_line(100, ng0);
    t2 = (t0 + 4256);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 4, t6, 4, t12, 4);
    t13 = (t0 + 4256);
    xsi_vlogvar_assign_value(t13, t4, 0, 0, 4);

LAB55:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 3056U);
    t3 = *((char **)t2);
    memset(t22, 0, 8);
    t2 = (t22 + 4);
    t6 = (t3 + 4);
    t7 = *((unsigned int *)t3);
    t8 = (t7 >> 0);
    *((unsigned int *)t22) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t11 & 255U);
    t14 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t14 & 255U);
    t12 = (t0 + 3776);
    t13 = (t12 + 56U);
    t19 = *((char **)t13);
    memset(t23, 0, 8);
    t20 = (t23 + 4);
    t24 = (t19 + 4);
    t15 = *((unsigned int *)t19);
    t16 = (t15 >> 0);
    *((unsigned int *)t23) = t16;
    t17 = *((unsigned int *)t24);
    t18 = (t17 >> 0);
    *((unsigned int *)t20) = t18;
    t38 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t38 & 255U);
    t39 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t39 & 255U);
    xsi_vlogtype_concat(t4, 16, 16, 2U, t23, 8, t22, 8);
    t25 = (t0 + 4096);
    xsi_vlogvar_assign_value(t25, t4, 0, 0, 16);
    goto LAB22;

LAB51:    t20 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB52;

LAB53:    xsi_set_current_line(95, ng0);

LAB56:    xsi_set_current_line(96, ng0);
    t25 = ((char*)((ng2)));
    t26 = (t0 + 3456);
    xsi_vlogvar_assign_value(t26, t25, 0, 0, 2);
    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4256);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    goto LAB55;

}


extern void work_m_00000000001257569354_4144471541_init()
{
	static char *pe[] = {(void *)Cont_51_0,(void *)Initial_56_1,(void *)Always_61_2};
	xsi_register_didat("work_m_00000000001257569354_4144471541", "isim/testcontroler_isim_beh.exe.sim/work/m_00000000001257569354_4144471541.didat");
	xsi_register_executes(pe);
}
