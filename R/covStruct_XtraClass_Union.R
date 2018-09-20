## ------------
## Union Class
## ------------

setClassUnion("covKernel", 
              c("covTensorProduct", "covIso", 
                "covScaling",
                "covUser")) #, "covAdditive0"))
