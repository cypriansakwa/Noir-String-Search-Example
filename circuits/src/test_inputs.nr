use crate::substring_search;

/// Helper to pad array to fixed length
fn pad_to_256(input: [u8], pad: u8) -> [u8; 256] {
    let mut out: [u8; 256] = [0; 256];
    let len = if input.len() > 256 { 256 } else { input.len() };
    for i in 0..len { out[i] = input[i]; }
    for i in len..256 { out[i] = pad; }
    out
}

fn pad_to_32(input: [u8], pad: u8) -> [u8; 32] {
    let mut out: [u8; 32] = [0; 32];
    let len = if input.len() > 32 { 32 } else { input.len() };
    for i in 0..len { out[i] = input[i]; }
    for i in len..32 { out[i] = pad; }
    out
}

#[test]
fn test_exact_match() {
    // "hello world", "world"
    let haystack = pad_to_256([104,101,108,108,111,32,119,111,114,108,100], 0);
    let needle = pad_to_32([119,111,114,108,100], 0);
    let (found, index) = substring_search(haystack, 11, needle, 5);
    assert(found == true);
    assert(index == 6);
}

#[test]
fn test_needle_at_start() {
    // "abc123", "abc"
    let haystack = pad_to_256([97, 98, 99, 49, 50, 51], 0);
    let needle = pad_to_32([97, 98, 99], 0);
    let (found, index) = substring_search(haystack, 6, needle, 3);
    assert(found == true);
    assert(index == 0);
}

#[test]
fn test_needle_at_end() {
    // "good morning", "ning"
    let haystack = pad_to_256([103, 111, 111, 100, 32, 109, 111, 114, 110, 105, 110, 103], 0);
    let needle = pad_to_32([110, 105, 110, 103], 0);
    let (found, index) = substring_search(haystack, 12, needle, 4);
    assert(found == true);
    assert(index == 8);
}

#[test]
fn test_haystack_equals_needle() {
    let text = [104,101,108,108,111,32,119,111,114,108,100];
    let haystack = pad_to_256(text, 0);
    let needle = pad_to_32(text, 0);
    let (found, index) = substring_search(haystack, 11, needle, 11);
    assert(found == true);
    assert(index == 0);
}

// Add more positive tests for chunk boundaries, maximal lengths, etc. as needed.