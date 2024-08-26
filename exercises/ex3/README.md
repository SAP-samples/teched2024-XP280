# Exercise 3 - Exercise 3 Description

In this exercise, we will create...

## Exercise 3.1 Sub Exercise 1 Description

After completing these steps you will have created...

1. Click here.
<br>![](/exercises/ex3/images/03_01_0010.png)

3.	Insert this line of code.
```abap
response->set_text( |Hello ABAP World! | ). 
```



## Exercise 3.2 Sub Exercise 2 Description

After completing these steps you will have...

1.	Enter this code.
```abap
DATA(lt_params) = request->get_form_fields(  ).
READ TABLE lt_params REFERENCE INTO DATA(lr_params) WITH KEY name = 'cmd'.
  IF sy-subrc = 0.
    response->set_status( i_code = 200
                     i_reason = 'Everything is fine').
    RETURN.
  ENDIF.

```

2.	Click here.
<br>![](/exercises/ex3/images/03_02_0010.png)

## Summary

You've now ...

Continue to - [Exercise 4 - Excercise 4 ](../ex4/README.md)
