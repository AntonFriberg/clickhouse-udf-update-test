#include <iostream>
#include <string>

int main(int argc, char **argv)
{
    std::string line;

    std::cin.tie(nullptr);
    std::cin.sync_with_stdio(false);

    std::cout.tie(nullptr);
    std::cout.sync_with_stdio(false);

    while (std::getline(std::cin, line)) {
        std::cout << "Key " << line << "\n";
    }

    return 0;
}
