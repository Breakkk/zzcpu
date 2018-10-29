
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name CPU -dir "E:/2018Aut/CPU/planAhead_run_3" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/2018Aut/CPU/Controller.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/2018Aut/CPU} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "Controller.ucf" [current_fileset -constrset]
add_files [list {Controller.ucf}] -fileset [get_property constrset [current_run]]
link_design
