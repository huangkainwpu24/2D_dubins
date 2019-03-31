<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
# 2D_dubins Path
**ref**：Cooperative Path Planning of Unmanned Aerial Vehicles

## input

You should input **the start position**(x and y),**start direction speed**,**start curvature **and the same as finish, all these parameters are in file named "main.m"

## output

* example of dubins path

![](images/example_dubins.png?raw=true)

the red line is the shortest dubins path,and the showing "LSL 10" in title means the dubins type is LSL and the radius of circle is 10, if you want to know more detils about how to calculate dubins, you can read file "dubins_trajectory.m" and  "dubins_types.m" 

## note

P35 in ref

**Table 2.1** Calculation of tangent exit and entry points for external tangent

|                    |      Start turn       |      Finish turn       |
| :----------------: | :-------------------: | :--------------------: |
| **$\alpha_{right}$** | $\alpha+\beta+\pi /2$ | $\alpha+\beta+\pi /2$  |
| **$\alpha_{left}$**  | $\beta-\alpha+3\pi/2$ | $\beta-\alpha+3\pi /2$ |

P39 in ref

**Table 2.2** Calculation of tangent exit and entry points for internal tangent

|                   |     Start turn      |    Finish turn     |
| :---------------: | :-----------------: | :----------------: |
| **$\alpha_{right}$**   |   $\alpha+\beta$    | $\beta-\alpha+\pi$ |
| **$\alpha_{left}$** | $\beta-\alpha+2\pi$ | $\alpha+\beta+\pi$ |

**Table 2.2** Calculation of tangent exit and entry points for internal tangent(**Changed**)

|                   |      Start turn      |       Finish turn       |
| :---------------: | :------------------: | :---------------------: |
| **$\alpha_{right}$**   | $\beta-\alpha+\pi/2$ |  $\beta+\alpha+\pi /2$  |
| **$\alpha_{left}$** | $\beta+\alpha-\pi/2$ | $-\alpha+\beta+3\pi /2$ |
