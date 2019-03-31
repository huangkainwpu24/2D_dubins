# 2D_dubins Path
**ref**：Cooperative Path Planning of Unmanned Aerial Vehicles

## input

You should input **the start position**(x and y),**start direction speed**,**start curvature**and the same as finish, all these parameters are in file named "main.m"

## output

* example of dubins path

![](images/example_dubins.png?raw=true)

the red line is the shortest dubins path,and the showing "LSL 10" in title means the dubins type is LSL and the radius of circle is 10, if you want to know more detils about how to calculate dubins, you can read file "dubins_trajectory.m" and  "dubins_types.m" 

## note

P35 in ref

**Table 2.1** Calculation of tangent exit and entry points for external tangent

![](images/Calculation_of_tangent_exit_and_entry_points_for_external_tangent.png?raw=true)

P39 in ref

**Table 2.2** Calculation of tangent exit and entry points for internal tangent

![](images/Calculation_of_tangent_exit_and_entry_points_for_internal_tangent.png?raw=true)

**Table 2.2** Calculation of tangent exit and entry points for internal tangent(**Changed**)

![](images/Calculation_of_tangent_exit_and_entry_points_for_internal_tangent(Changed).png?raw_true)
