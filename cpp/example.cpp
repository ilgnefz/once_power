// cpp/image_processor.cpp
#include <vector>
#include <cstdint>

extern "C" uint8_t* process_image(uint8_t* data, int32_t length, int32_t* out_length) {
    // 假设将输入数据每个字节加1（示例逻辑）
    std::vector<uint8_t> result(data, data + length);
    for (auto& byte : result) byte += 1;

    // 分配内存（需在Dart中释放）
    uint8_t* output = new uint8_t[result.size()];
    std::copy(result.begin(), result.end(), output);
    *out_length = result.size();
    return output;
}