package rnd.fahim.javaspringbootawsrnd;

import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import rnd.fahim.javaspringbootawsrnd.secrets.ExternalServiceSecretManager;

// Runs without AWS access (e.g. in CI): SQS listeners would connect to real
// queues, and the startup listener reads Secrets Manager / Parameter Store.
@SpringBootTest(properties = "spring.cloud.aws.sqs.enabled=false")
class JavaSpringBootAwsRndApplicationTests {

  @TestConfiguration
  static class NoAwsSecrets {

    // Stubbed before the context starts, because the startup listener uses it
    @Bean
    @Primary
    ExternalServiceSecretManager stubSecretManager() {
      ExternalServiceSecretManager secretManager = mock(ExternalServiceSecretManager.class);
      when(secretManager.getParameter(anyString(), anyBoolean())).thenReturn("3");
      return secretManager;
    }
  }

  @Test
  void contextLoads() {}
}
