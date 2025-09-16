package kr.co.deploymenttestrs.controller;

import kr.co.deploymenttestrs.service.DeploymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class DeploymentController {

    private final DeploymentService deploymentService;

    @GetMapping("/deploy")
    public ResponseEntity<String> deploy() {
        return ResponseEntity.ok("Deployment started");
    }

    @GetMapping("/health")
    public String ping() {
        return "ok";
        // ping check
    }
}
