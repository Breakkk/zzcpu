
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name SerialInterface -dir "G:/ISE_Project/SerialInterface/planAhead_run_3" -part xc3s1200efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "controller.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {controller.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top controller $srcset
add_files [list {controller.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s1200efg320-4
