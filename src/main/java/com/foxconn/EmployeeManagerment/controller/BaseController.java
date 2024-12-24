package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.message.ResponseMessage;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public  abstract class BaseController {
    protected <T> ResponseEntity<?> toSuccessResult(T data, String successMessage) {
        ResponseMessage<T> message = new ResponseMessage<>();

        message.setCode("200");
        message.setSuccess(true);
        message.setMessage(successMessage);
        message.setData(data);

        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    protected <T> ResponseEntity<?> toExceptionResult(String errorMessage, int code) {
        ResponseMessage<T> message = new ResponseMessage<>();

        message.setSuccess(false);
        message.setCode(code + "");
        message.setMessage(errorMessage);

        return new ResponseEntity<>(message, HttpStatus.valueOf(code));
    }
}
