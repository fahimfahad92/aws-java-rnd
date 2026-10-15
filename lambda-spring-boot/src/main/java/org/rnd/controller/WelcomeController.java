package org.rnd.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

  @RequestMapping(path = "/welcome", method = RequestMethod.GET)
  public Map<String, String> welcome() {
    Map<String, String> response = new HashMap<>();
    response.put("message", "Welcome guest. This is a test template for Java Spring Boot Lambda!");
    return response;
  }
}
