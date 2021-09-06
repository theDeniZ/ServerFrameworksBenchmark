package com.exxeta.test.Benchmarking;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.config.Task;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/")
public class SimpleController {

  @GetMapping(
      value = "/simple",
      produces = { "application/json" }
  )
  public ResponseEntity<Integer> getSimpleResponse() {
    return ResponseEntity.ok(Utils.getSimpleResponse());
  }

  @GetMapping(
      value = "/json",
      produces = { "application/json" }
  )
  public ResponseEntity<JsonDTO> getHarderResponse() {
    return ResponseEntity.ok(Utils.getHarderResponse());
  }

  @GetMapping(
      value = "/static",
      produces = { "application/json" }
  )
  public ResponseEntity<Integer> getAsyncResponse() throws InterruptedException {
    final List<Integer> response = new ArrayList<>();
    ExecutorService executor = Executors.newFixedThreadPool(1);
    executor.submit(() -> {
      try {
        Thread.sleep(500);
      } catch (InterruptedException e) {
        // ignore
      }
      response.add(Utils.getSimpleResponse());
    });
    executor.shutdown();
    executor.awaitTermination(2000, TimeUnit.MILLISECONDS);
    return ResponseEntity.ok(response.get(0));
  }
}
