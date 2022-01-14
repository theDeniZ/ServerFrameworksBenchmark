# Server Frameworks back-to-back comparison

## TL;DR

Winners:

| Performance | Latency | CPU | Memory |
| ----------- | ------- | --- | ------ |
| Gin         | Gin     | Gin | Vapor  |

## Intro

Today there are too many ways to provide a server with an App. As usual, a programmer will chose one, with which he / she has most experience.

But is it worth it to switch to a new server framework or even a programming language if a new framework is more attractive? Lets find out.

In this article the following server frameworks will be compared:

- [**Java** - Spring Boot](https://spring.io/projects/spring-boot)
- [**JavaScript** - Node.js](https://nodejs.org/en/)
- [**Swift** - Vapor](https://vapor.codes)
- [**Go** - Gin](https://gin-gonic.com)

We will measure:
- performance (requests / time)
- memory footprint
- cpu usage

## Setup

To reproduce the results here is the setup used for measuring performance:
- Host:
  - iMac 24", Apple M1, 16Gb RAM
  - Oracle JDK 16.0.2
  - Node 16.3.0
  - Swift 5.4.2
  - Go 1.17
- Tester:
  - MacBook Pro 15", 2.2 GHz 6-Core Intel Core i7, 32Gb RAM
  - [wrk](https://github.com/wg/wrk)

The connection was established via Thunderbolt Bridge.

To achieve best performance, there should be no open Apps except the process under test.

### Spring Boot

Spring boot was launched with `mvn spring-boot:run`. 

Only one process is needed, as Java can manage multiple cores of CPU.

### Node.js

Node was launched with `npm run start`.

Node can only operate on 1 CPU for a given process. We launch 8 threads from `index.js` thus taking advantage of all available cores. Change this number to match your host.

### Vapor

Vapor can manage all cores from one process. Vapor was launched with `vapor run serve -e prod`.

### Gin

Gin can manage all cores from one process. Gin was launched with `go run main.go`.

### Tester

To test the frameworks, `wrk -d 10m -t 4 -c 50 http://127.0.0.1:8080` is used with the following parameters:
- `-d 10m` - run for 10 minutes
- `-t 4` - use 4 threads
- `-c 50` - use 50 connections

These parameters were found to give the best performance measurements.

Used [test parameters](./run_all.sh) as well as [1 min](./run_all_result.log) and [10 min](./run_all_result_1m.log) test results are provided.

## Test cases

The test were run multiple times:
1. Test of performance over 1 minute
2. Test of performance over 10 minutes
3. Test of CPU & Memory usage

There were 3 test cases - simple, JSON and static.

### Simple

In a simple scenarion a response is a random number between 0 and 1000. It should suffice for a baseline of a simple response from server.

### JSON

Typically a backend server will return a JSON object. In our simple test no Database connection was made to reduce all influencing factors. A simple JSON object is returned as a response containing 20 keys with 20 values - random numbers generated between 0 and 1000.

### Static

As a standart feature of a given framework a static file is provided at path of an empty html file. No implementation of any sort is required - only a configuration of a given framework.

## Short results

### Simple response

![simple winner diagram](./images/simple.png)

### Json response

![json winner diagram](./images/json.png)

### Static response

![static winner diagram](./images/static.png)

## Detailed results / 10 mins

Now that we know who is the winner, lets have a look at the detailed results of each categories:

Best results are marked **bold** and worst - *italic*

Average Latency will be calculated taking an average of all average latencies of 3 request types. Max Latency - max over all 3 request types.

|                 | Vapor      | Spring Boot | Node     | Gin          |
| --------------- | ---------- | ----------- | -------- | ------------ |
| Simple requests | *13029793* | 14620634    | 22724555 | **63284600** |
| Json requests   | *13088069* | 14271824    | 20564804 | **46688950** |
| Static requests | 11919910   | *9097371*   | 17069023 | **56640135** |
| Average Latency | 2.40ms     | 2.91ms      | *6.98ms* | **573.27us** |
| Max Latency     | 106.76ms   | *475.51ms*  | 261.08ms | **52.06ms**  |

## Detailed results / 1 min

|                 | Vapor     | Spring Boot | Node     | Gin          |
| --------------- | --------- | ----------- | -------- | ------------ |
| Simple requests | *1327352* | 1460237     | 2196821  | **7185111**  |
| Json requests   | *1285447* | 1519358     | 2051916  | **5107281**  |
| Static requests | 1174664   | *928020*    | 1676733  | **5724528**  |
| Average Latency | 2.41ms    | 4.35ms      | *6.78ms* | **534.53us** |
| Max Latency     | 79.48ms   | *447.88ms*  | 257.40ms | **34.36ms**  |

## Performance stability

We have the test results over 1 and 10 minutes. Lets take a look at the performance rate - how much efficiency stays after 10 min compared to expectation after 1 min test.

The result is calculated as **Result of 10 min test / Result of 1 min test * 10**

|                               | Vapor  | Spring Boot | Node   | Gin    |
| ----------------------------- | ------ | ----------- | ------ | ------ |
| Simple requests power drop, % | 98.1   | 100.12      | 103.44 | 88.08  |
| Json requests power drop, %   | 101.81 | 93.93       | 100.22 | 91.42  |
| Static requests power drop, % | 101.48 | 98.03       | 101.80 | 98.94  |
| Average Latency climb, %      | 99.59  | 66.90       | 102.95 | 107.25 |
| Max Latency   climb, %        | 134.32 | 106.17      | 101.43 | 120.06 |

## CPU & Memory Usage

|                | Vapor | Spring Boot | Node  | Gin   |
| -------------- | ----- | ----------- | ----- | ----- |
| Average CPU, % | 746.4 | 550.9       | 411.6 | 384.9 |
| Max Memory, MB | 13.0  | 621.6       | 519.9 | 30.0  |

Important: Node has no multicore ability, thus taking at max 1 core / process. The number of processes of Node tests was increased to the number of cores on the test machine to make the game fair.

