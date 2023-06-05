# Grpc Service Example with proxy mode

The `examples/grpc-service` folder contains a Dapr enabled `server` app and a `client` app that uses this SDK to invoke grpc methos via grpc stub, The `server` app is available as gRPC. The `client` app can target either one of these for service to service and binding invocations.


## Step

### Prepare

- Dapr installed

### Run server as a dapr app

<!-- STEP
name: Run grpc server with dapr proxy mode
output_match_mode: substring
expected_stdout_lines:
  - 'Received: Dapr'
background: true
sleep: 15
-->

```bash
dapr run --app-id grpc-server \
         --app-port 50050 \
         --log-level debug \
         go run ./server/main.go
```

<!-- END_STEP -->

### Run grpc client

<!-- STEP
name: Run grpc client
expected_stdout_lines:
  - 'Greeting: Hello Dapr'
output_match_mode: substring
background: true
sleep: 15
-->

```bash
dapr run --app-id grpc-client \
         --log-level debug \
         --dapr-grpc-port 50007
         go run ./client/main.go
```

<!-- END_STEP -->

### Cleanup

<!-- STEP
expected_stdout_lines:
  - '✅  Exited Dapr successfully'
expected_stderr_lines:
name: Shutdown dapr
-->

```bash
dapr stop --app-id sub
(lsof -i:8080 | grep sub) | awk '{print $2}' | xargs  kill
```

<!-- END_STEP -->

## Result

```shell
== APP == 2023/03/29 21:36:07 event - PubsubName: messages, Topic: neworder, ID: 82427280-1c18-4fab-b901-c7e68d295d31, Data: ping
== APP == 2023/03/29 21:36:07 event - PubsubName: messages, Topic: neworder, ID: cc13829c-af77-4303-a4d7-55cdc0b0fa7d, Data: multi-pong
== APP == 2023/03/29 21:36:07 event - PubsubName: messages, Topic: neworder, ID: 0147f10a-d6c3-4b16-ad5a-6776956757dd, Data: multi-ping
```
