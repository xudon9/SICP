/*
 * Author: Wang Hsutung
 * Date: 2016/10/11
 * Locale: Wuhan, Hubei
 * Email: hsu[AT]whu.edu.cn
 */

#include <list>
#include <queue>
#include <string>
#include <iostream>
#include <algorithm>
#include <functional>

class Agenda {
    struct Segment {
        int time;
        std::queue<std::function<void()>> queue;

        // Segment(int time) : time(time) {}
        Segment(int time, const std::function<void()> &proc) : time(time) {
            queue.push(proc);
        }
    };

private:
    int current_time;
    std::list<Segment> segments;

public:
    Agenda() : current_time(0) {}

    void set_current_time(int newtime) { current_time = newtime; }

    bool empty() { return segments.empty(); }

    void add_to_agenda(int time, std::function<void()> action) {
        for (auto it = segments.begin(); it != segments.end(); ++it) {
            if (time == it->time) {
                it->queue.push(action);
                return;
            } else if (time < it->time) {
                segments.insert(it, Segment(time, action));
                return;
            }
        }
        segments.emplace_back(time, action);
    }

    void after_delay(int delay_time, std::function<void()> action) {
        add_to_agenda(current_time + delay_time, action);
    }

    int get_current_time() { return current_time; }

    void propagate() {
        while (!segments.empty()) {
            auto &segment = segments.front();
            while (!segment.queue.empty()) {
                set_current_time(segment.time);
                segment.queue.front()();
                segment.queue.pop();
            }
            segments.pop_front();
        }
        std::cout << "-- Done --" << std::endl;
    }
} agenda;

class Wire {
private:
    std::string name;
    bool signal_value;
    std::list<std::function<void()>> action_procedures;

public:
    Wire(const std::string &name = "") : name(name), signal_value(false) {}

    const std::string &get_name() const { return name; }
    bool get_signal() const { return signal_value; }

    void set_name(const std::string &newname) { name = newname; }
    void set_signal(bool new_value) {
        if (new_value != signal_value) {
            signal_value = new_value;
            std::for_each(action_procedures.begin(), action_procedures.end(),
                    [](std::function<void()> &f) { f(); });
        }
    }

    void add_action(const std::function<void()> &proc) {
        action_procedures.emplace_front(proc);
        proc();
    }
};

namespace Gate {
    void inverter(Wire &input, Wire &output) {
        const int inverter_delay = 2;
        auto invert_input = [&] {
            agenda.after_delay(inverter_delay,
                    [&] { output.set_signal(!input.get_signal()); });
        };
        input.add_action(invert_input);
    }

    void and_gate(Wire &a1, Wire &a2, Wire &output) {
        const int and_date_delay = 3;
        auto and_action_procedure = [&] {
            agenda.after_delay(and_date_delay, [&] {
                    output.set_signal(a1.get_signal() && a2.get_signal());
                    });
        };
        a1.add_action(and_action_procedure);
        a2.add_action(and_action_procedure);
    }

    void or_gate(Wire &a1, Wire &a2, Wire &output) {
        const int or_date_delay = 5;
        auto or_action_procedure = [&] {
            agenda.after_delay(or_date_delay, [&] {
                    output.set_signal(a1.get_signal() || a2.get_signal());
                    });
        };
        a1.add_action(or_action_procedure);
        a2.add_action(or_action_procedure);
    }
}

void probe(Wire &wire) {
    wire.add_action([&wire] {
            std::cout << wire.get_name() << "\t" << agenda.get_current_time()
            << "\tNew-value = " << wire.get_signal() << std::endl;
            });
}

/****************** Hald adder ******************\

       +--------------------------------------+
       |         ____                         |
   A --------*---\   \ D               ___    |
       |     |    >   >---------------|   \   |
       |  +--|---/___/                |    )----- S
       |  |  |              |\  E  +--|___/   |
       |  |  |           +--| >o---+          |
       |  |  |    ___    |  |/                |
       |  |  +---|   \   |                    |
       |  |      |    )--*----------------------- C
   B -----*------|___/                        |
       |                                      |
       +--------------------------------------+

\************************************************/
class HalfAdder {
private:
    Wire d, e;

public:
    HalfAdder(Wire &a, Wire &b, Wire &s, Wire &c) {
        Gate::or_gate(a, b, d);
        Gate::and_gate(a, b, c);
        Gate::inverter(c, e);
        Gate::and_gate(d, e, s);
    }
};

/****************** Full adder ******************\

       +----------------------------------+
       |              +-------+           |
   A -----------------+ half  +-------------- SUM
       |  +-------+   | adder |   ____    |
   B -----+ half  +---+       +---\   \   |
       |  | adder |   +-------+    >or >----- Cout
   C -----+       +---------------/___/   |
       |  +-------+                       |
       +----------------------------------+*

\************************************************/
class FullAdder {
private:
    Wire s, c1, c2;
    HalfAdder h1, h2;

public:
    FullAdder(Wire &a, Wire &b, Wire &c_in, Wire &sum, Wire &c_out)
        : h1(b, c_in, s, c1), h2(a, s, sum, c2) {
            Gate::or_gate(c1, c2, c_out);
        }
};

/*
   :                                              :   :
   : A_0 B_0   C_0   A_1 B_1   C_1   A_2 B_2   C_2:   : A_n B_n C_n=0
   :  |   |   +---+   |   |   +---+   |   |   +-----  :  |   |   +-
   |  |   |   |   |   |   |   |   |   |   |   |   :   :  |   |   |
   : ++---+---++  |  ++---+---++  |  ++---+---++  :   : ++---+---++
   : |   FA    |  |  |   FA    |  |  |   FA    |  :   : |   FA    |
   : +--+---+--+  |  +--+---+--+  |  +--+---+--+  :   : +--+---+--+
   :    |   |     |     |   |     |     |   |     :   :    |   |
C ------+   |     +-----+   |     +-----+   |     :  ------+   |
   :        |       C_0     |       C_1     |     :   :C_(n-1) |
   :        |               |               |     :   :        |
           S_0             S_1             S_2                S_n
*/
int main(void) {
    using std::cout;
    using std::endl;

    const int n = 4;
    Wire a[n], b[n], c[n + 1], s[n];
    std::list<FullAdder> full_adders;
    bool addend[] = {0, 1, 0, 1}, augend[] = {1, 1, 1, 1};

    for (int i = 0; i < n; ++i) {
        a[i].set_name("A" + std::string(1, '0' + i));
        b[i].set_name("B" + std::string(1, '0' + i));
        c[i].set_name("C" + std::string(1, '0' + i));
        s[i].set_name("S" + std::string(1, '0' + i));
        full_adders.emplace_back(a[i], b[i], c[i], s[i], c[i ? i - 1 : n]);

        a[i].set_signal(addend[i]);
        b[i].set_signal(augend[i]);
        probe(s[i]);
    }
    c[4].set_name("C");
    probe(c[4]);

    agenda.propagate();

    exit(EXIT_SUCCESS);
}
