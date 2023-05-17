#include <cstdint>
#include <iostream>

uint64_t count_flops(int N, int bandwidth) {
    uint64_t total = 0;
    for (int i = 1; i <= N; ++i) {
        const int r = std::max(1, i - bandwidth);
        for (int j = r; j <= i; ++j) {
            for (int l = r; l < j; ++l) {
                total += 2;
            }
            total += 2;
        }
    }

    return total;
}




int main()
{
    constexpr int N = 100000;

    for (int bw = 50; bw <= 200; bw += 10) {
        std::cout << bw << ", " << count_flops(N, bw) << "\n";
    }
    for (int bw = 300; bw <= 2000; bw += 100) {
        std::cout << bw << ", " << count_flops(N, bw) << "\n";
    }
    return 0;
}
