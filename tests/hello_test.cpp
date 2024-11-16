#include <gtest/gtest.h>

#include "../src/include/calculator.h"

// Test case for the add function
TEST(HelloTest, AddPositiveNumbers) {
    Calculator calc;
    EXPECT_EQ(calc.add(1, 2), 3);
    EXPECT_EQ(calc.add(5, 7), 12);
}

TEST(HelloTest, AddNegativeNumbers) {
    Calculator calc;
    EXPECT_EQ(calc.add(-1, -2), -3);
    EXPECT_EQ(calc.add(-5, -7), -12);
}

// Main function for GoogleTest
int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
