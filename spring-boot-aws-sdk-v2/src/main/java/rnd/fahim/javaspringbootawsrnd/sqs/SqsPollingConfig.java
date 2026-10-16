package rnd.fahim.javaspringbootawsrnd.sqs;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Turns on {@link SqsService#pollMessages()}: manual polling with the SDK, as an alternative to the
 * {@code @SqsListener} methods. Off by default because both read the standard queue and would
 * compete for its messages.
 */
@Configuration
@EnableScheduling
@ConditionalOnProperty(name = "aws.sqs.manual-polling.enabled", havingValue = "true")
public class SqsPollingConfig {}
