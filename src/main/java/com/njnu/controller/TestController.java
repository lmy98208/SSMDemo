package com.njnu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("test")
public class TestController {
    @RequestMapping("hello")
    public String hello(){
        System.out.println("hello");
        return "hello";
    }
}
