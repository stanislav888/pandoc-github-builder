```markdown
# Dmitry Ivanov
## C++ Software Development Engineer

> *"Clean code, high performance, and modern C++ — my professional motto."*

---

## 📫 Contact

- **Email:** dmitry.ivanov@example.com
- **GitHub:** [github.com/divanov](https://github.com/divanov)
- **Telegram:** @dmitry_dev
- **LinkedIn:** [linkedin.com/in/dmitry-ivanov](https://linkedin.com/in/dmitry-ivanov)
- **Location:** Moscow, Russia

[Back to top](#dmitry-ivanov)

---

## Table of Contents

1. [Professional Summary](#-professional-summary)
2. [Core Competencies](#-core-competencies)
3. [Work Experience](#-work-experience)
4. [Education](#-education)
5. [Certifications](#-certifications)
6. [Notable Projects](#-notable-projects)
7. [Achievements](#-achievements)
8. [Languages](#-languages)
9. [References](#-references)

---

## 🎯 Professional Summary

Results-driven **C++ Software Engineer** with **8+ years** of experience in:

- **High‑load systems**
- **Low‑latency applications**
- **Embedded solutions**

Proven track record in:

| Domain   | Key Achievements |
|----------|------------------|
| FinTech  | HFT engine with <10µs latency |
| Telecom  | SS7 stack optimization |
| GameDev  | Multiplayer RPG core logic |

> ⚡ Passionate about **clean code**, **performance optimization**, and modern **C++17/20**.

---

## 🧠 Core Competencies

### Languages & Technologies
- **C++** (11/14/17/20) — advanced
- **STL, Boost, Asio, Poco, nlohmann/json**
- **Multithreading, Lock‑free structures, MPSC queues**
- **Python, Bash, CMake, Conan, vcpkg**

### Tools & Ecosystem
- **Git, GitLab CI, GitHub Actions, Jenkins**
- **Docker, Podman, Kubernetes (basics)**
- **Valgrind, perf, gdb, sanitizers**
- **JIRA, Confluence, Code Review**

### Databases & Networking
- **PostgreSQL, Redis, MongoDB**
- **REST API, WebSockets, gRPC, ZeroMQ**
- **TCP/IP, UDP, Multicast, DDS**

```cpp
// Example: lock-free queue snippet
template<typename T>
class MPSCQueue {
    std::atomic<Node*> head;
    std::atomic<Node*> tail;
public:
    void push(T value);
    bool pop(T& out);
};
```

---

## 💼 Work Experience

### **Senior C++ Developer** | **FinTech Corp** | 2022 – Present

**Key responsibilities:**

1. Design and implement **HFT engine**
2. Optimize network stack
3. Mentor junior developers

**Achievements:**

- ✅ Designed a **high‑frequency trading (HFT) engine** with latency **<10µs**
- ✅ Optimized network stack, reducing overall latency by **30%**
- ✅ Integrated **Google Benchmark** and **Sanitizers**, increasing stability to **99.99%**
- ✅ Implemented a **lock‑free MPSC queue** achieving **3M ops/sec**

---

### **C++ Software Engineer** | **GameDev Studio** | 2018 – 2022

- Developed **core gameplay logic** for a large‑scale multiplayer RPG
- Migrated build system to **CMake + Conan** for 15+ microservices
- Set up a **CI/CD pipeline (GitLab)** for automated testing and deployment
- Participated in **migration from C++14 to C++20**, gaining a **20% performance boost**

> 💡 **Insight:** The migration to C++20 reduced compilation time by 35% and improved code readability through concepts and ranges.

---

### **Junior C++ Developer** | **Telecom Solutions** | 2016 – 2018

- Maintained and refactored legacy **SS7 signaling stack**
- Implemented unit tests using **Google Test**, increasing code coverage to **85%**
- Fixed **memory leaks and race conditions** detected by Valgrind and TSAN

---

## 🎓 Education

### **M.Sc. in Computer Science**
*Moscow Institute of Physics and Technology (MIPT)*  
*2014 – 2020*

**Courses completed:**

- Advanced Algorithms
- Distributed Systems
- Compiler Design
- Low‑level Optimization

**Thesis:** *Lock‑free data structures for high‑performance computing*

---

## 📜 Certifications

| Certification | Year | Issuer |
|---------------|------|--------|
| C++ Institute Certified Professional Programmer (CPA) | 2021 | C++ Institute |
| Advanced C++: Multithreading & Optimization | 2022 | Coursera |
| **New:** Docker Deep Dive | 2025 | Udemy |
| **New:** Kubernetes for Developers | 2025 | Linux Foundation |

---

## 🛠️ Notable Projects

### 1. **Lock‑free Queue Library**
- Header‑only C++17 library with **MPSC** and **SPSC** queues
- Benchmark shows **2.5x speedup** over `std::queue` with mutex
- 📎 [github.com/divanov/lfqueue](https://github.com/divanov/lfqueue)

### 2. **Async REST Client**
- Built on **Boost.Asio** with connection pooling and retry logic
- Used in production by **5+ internal services**
- Example usage:

```cpp
AsyncRestClient client("https://api.example.com");
auto response = client.get("/users/42").get();
assert(response.status_code == 200);
```

### 3. **Trading Simulator** (side project)
- Simulates market data feed using **UDP multicast**
- Processes **1M messages/sec** on a single core

---

## 🏆 Achievements

- 🎤 **Speaker** at C++ Russia 2023: *Lock‑free data structures in finance*
- 👥 **Organizer** of Moscow C++ Meetup (2021–2024)
- 📝 **Author** of 5+ technical articles on Habr (40K+ total reads)

---

## 📄 Languages

| Language | Proficiency |
|----------|-------------|
| Russian  | Native      |
| English  | C1 (IELTS 7.5) |

---

## 🧩 References

Available upon request.

---

*Last updated: June 2026*

[⬆ Back to top](#dmitry-ivanov)
```