
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name SerialInterface -dir "G:/ISE_Project/SerialInterface/planAhead_run_5" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "G:/ISE_Project/SerialInterface/controller.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {G:/ISE_Project/SerialInterface} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "controller.ucf" [current_fileset -constrset]
add_files [list {controller.ucf}] -fileset [get_property constrset [current_run]]
link_design
