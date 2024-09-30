package com.example.crud_api.payloads;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApiResponse <T>{
    private String status;
    private Object data;

    public ApiResponse(String status, Object data) {
        this.status = status;
        this.data = data;
    }
}
