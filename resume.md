
# DMITRY IVANOV
**Senior C++ Software Engineer / Technical Lead**

**Location:** Moscow, Russia | **Phone:** +7 (900) 123-45-67
**Email:** d.ivanov.cpp@gmail.com | **LinkedIn:** [linkedin.com/in/divanov-cpp](https://linkedin.com)
**GitHub:** [github.com/dmitry-ivanov-core](https://github.com) | **English:** Upper-Intermediate (B2)
**Relocation:** Open to relocation (Serbia/Montenegro/Armenia), Remote/Hybrid/On-site

---

### 🎯 PROFESSIONAL SUMMARY

Senior C++ Software Engineer with **8+ years of experience** in designing and developing high-load, low-latency distributed systems. Expert in Modern C++ (11/14/17/20/23) with a strong focus on performance optimization, lock-free programming, and network programming. Proven technical leadership experience, mentoring teams, and establishing best coding practices. Passionate about clean architecture, compile-time computation, and squeezing every microsecond out of the hot path.

---

### 🛠️ TECHNICAL SKILLS

| Category | Technologies & Tools |
| :--- | :--- |
| **Languages** | C++ (C++11/14/17/20/23), C, Python, SQL, Bash |
| **Concurrency** | `std::thread`, `std::async`, OpenMP, Lock-free Queues (MoodyCamel), Memory Ordering, Thread Pools, Coroutines |
| **Networking** | Boost.Asio, libuv, gRPC, REST (cpprestsdk), WebSockets, TCP/UDP Multicast |
| **Libraries/Frameworks** | Boost (Asio, Beast, Spirit, Intrusive), STL, Protobuf, FlatBuffers, OpenCV |
| **Build & CI/CD** | CMake, Ninja, Conan, vcpkg, Docker, Kubernetes (basics), Jenkins, GitLab CI |
| **Databases** | PostgreSQL, Redis, MongoDB, ClickHouse |
| **Dev Tools** | GDB, RR, Valgrind, perf, VTune, Sanitizers (ASan, TSan, UBSan), libFuzzer |
| **Paradigms** | OOP, Generic/Metaprogramming, Functional, Actor Model |
| **OS** | Linux (Primary), Windows, macOS |

---

### 💼 WORK EXPERIENCE

---

#### **FinCore Technologies** — *FinTech / Algorithmic Trading*
**Senior C++ Developer / Tech Lead** | *Jan 2021 — Present (3.5 years)*
*Led the development of the trading robot core and market data infrastructure.*

- **Leadership & Architecture:**
    - Managed a team of 4 C++ engineers: conducted code reviews, mentored junior/middle developers, and enforced the Google C++ Style Guide.
    - Architected an asynchronous market data processing engine handling **500,000 messages per second** per core.
    - Decomposed a legacy monolith into microservices, reducing project build time by **40%** (from 20 mins to 12 mins).

- **Performance Optimization:**
    - Optimized the critical order execution path using lock-free queues and custom memory pools (Arena allocators), reducing P99 latency from **15 µs to 3.2 µs**.
    - Utilized heavy compile-time computation (`constexpr`, template metaprogramming) for parsing binary exchange protocols (ITCH, FAST), completely eliminating runtime overhead in the parsing layer.
    - Developed a high-throughput serialization library based on FlatBuffers, achieving a **3x speedup** in data transmission compared to the previous Protobuf implementation.

- **Reliability & Testing:**
    - Engineered a fault-tolerant client gateway using C++20 Coroutines and Boost.Asio with automatic session recovery and persistent logging.
    - Achieved **85% unit test coverage** (GoogleTest) for the core modules and integrated fuzz testing (libFuzzer) into the CI pipeline to catch edge cases in protocol handlers.

**Tech Stack:** C++17/20, Boost, Linux Kernel Tuning, TCP/IP, Redis, Docker, Prometheus/Grafana.

---

#### **GameVerse Studio** — *AAA Game Development*
**Middle/Senior C++ Gameplay Programmer** | *May 2018 — Dec 2020 (2 years 8 months)*
*Developed server-side and client-side logic for a multiplayer shooter (Unreal Engine 4/5).*

- **Gameplay Logic:**
    - Implemented a Gameplay Ability System (GAS) in C++ with visual scripting wrappers for game designers, enabling fast iteration on character skills.
    - Developed a robust replication system with client-side prediction and dead reckoning, ensuring smooth gameplay for users with ping up to 150ms.
    - Integrated PhysX physics engine for destructible environments and dynamic rigid body interactions.

- **Engine Optimization:**
    - Profiled the Game Thread and Render Thread, identifying an animation system bottleneck. Optimized bone transform calculations using SIMD (SSE/AVX) intrinsics, resulting in a **20% FPS increase** on console platforms (PS4/Xbox One).
    - Resolved memory fragmentation issues by implementing custom STL-compatible allocators tailored for console memory models.

**Tech Stack:** C++17, Unreal Engine 4/5, Blueprints, SIMD (SSE/AVX), Network Replication, Perforce.

---

#### **DataStream LLC** — *Big Data / Video Processing*
**C++ Software Engineer** | *Sep 2015 — Apr 2018 (2 years 8 months)*
*Developed a high-load server for real-time video streaming and telemetry processing.*

- Designed a multi-threaded asynchronous server using **Boost.Asio** and **OpenCV** to process video streams from IP cameras in real-time.
- Implemented a flexible pipeline pattern allowing users to configure video processing chains (filters, transformations) without recompilation via dynamic plugin loading.
- Created a client-server communication layer based on Protocol Buffers (gRPC) for interaction with mobile applications.
- Developed a Redis caching layer for object detection results, which decreased the load on the GPU processing farm by **30%**.

**Tech Stack:** C++11/14, Boost.Asio, OpenCV, gRPC, Redis, CMake, Linux.

---

### 🎓 EDUCATION

- **Master of Science in Computer Science**
    *Moscow Institute of Physics and Technology (MIPT), Department of Radio Engineering and Cybernetics* — 2015
    *Thesis:* "Latency Optimization Methods in Distributed Real-Time Systems Using Asynchronous I/O."

---

### 🏆 ACHIEVEMENTS & CERTIFICATIONS

- **Winner of "Digital Breakthrough 2023" Hackathon** (Case: "Credit Risk Calculation Optimization using C++ and CUDA").
- **Certification:** "Modern C++ Design Patterns" (UML, OOP, Observer, Factory, Strategy) — Coursera.
- **Open Source Contributor:** Contributed memory ordering bug fixes to the `concurrentqueue` library.

---

### 📝 ADDITIONAL INFORMATION

- **Languages:** English (Upper-Intermediate, reading technical documentation, conducting stand-ups), Russian (Native).
- **Interests:** HPC, 3D Graphics (Vulkan), Compiler Theory, Open Source Hardware.
- **Work Authorization:** Remote (IP/Self-employed), ready for visa sponsorship if relocation is required.