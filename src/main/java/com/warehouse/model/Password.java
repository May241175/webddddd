package com.warehouse.model;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = PasswordConstraintValidator.class)
@Target({ ElementType.METHOD, ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface Password {

    String message() default 
        "Password must be at least 8 characters long and contain a digit, lowercase, uppercase, and special character.";

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
