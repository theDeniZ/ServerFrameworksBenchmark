package com.exxeta.test.Benchmarking;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Utils {

  public static Random random = new Random();

  public static Integer getSimpleResponse() {
    return random.nextInt(100);
  }

  public static JsonDTO getHarderResponse() {
    return new JsonDTO();
  }
}
