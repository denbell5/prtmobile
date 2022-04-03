$i = 1
for (; $i -le 10; $i++) {
  flutter drive `
    --driver=integration_test\expandable\perf_driver.dart `
    --target=integration_test\expandable\expandable_test.dart `
    --profile `
    --no-dds
}

