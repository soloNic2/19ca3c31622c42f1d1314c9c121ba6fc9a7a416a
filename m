Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5F3C7EE23
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjEWTag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjEWTaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:30:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED392E4B
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8338f2103so164154276.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684870198; x=1687462198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZmYPx+hNZF6hMw7QkbNn9tzMfh0FkGsupjfclJD9KE=;
        b=z1OkahkSsZyibRkDtKkkS/ceaSDEj7vWh3NEmQ41WhlX7WJxsjq8MIBQRxV/9EoMI0
         nqqXgs/mNxFrTpC9BxTYUyU11epkE6q5sVkpchCIpw8xg0YwvviDCCcjSjSsBw7zoDCD
         UKJAh2HkbAD/h55+AjW1kXWohwEmyq7Q17X/S6FcL/clA6o7dhr99+ze/2rOTY1CJAU4
         73rPuVZRCRw6p+lIy5vHKBCL6mhoRSNWWOW5aMRgu5HLQZcANDTWuH1/WlR4+Fpx9Ohy
         vArzjVBNR+Pr0teV/LC0aFkIK5OPKC+5DSf9IA+EnLNM2cZNGOfKlVfuLwp9hfTqf2Yr
         zEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870198; x=1687462198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZmYPx+hNZF6hMw7QkbNn9tzMfh0FkGsupjfclJD9KE=;
        b=Q2W0GLee/eWsNexK8tGq0cbUHofdrNG+17kr0/DuwKRW2WluGEUoANnwgoyUXFf5NI
         pfKPR15iFt2L8MUrimE34xkc4mSfDutniKYRgr7Mkwll50/PTyb7CgMRoIkPsFE3EgDq
         pptrCv9rfwWpCEr9gHYtanFw44fklvZC/KH5Jf2HCQSWX5lqpCjS36MWMPbfyV2yAeWf
         u/Veby3tKzpPoVSWPfdq8nQwjyxpobA0MoKkhoaYd1qlzPpqcm2zetD1LmC6s68RFUDr
         AWemXOQnb9Cc/z8p3LhsYqnu3JKfe4nCFYtVEwz3KNTRtZT44jP0W8pCO9aQLwzFrXne
         N1UQ==
X-Gm-Message-State: AC+VfDysgDLM07O/2on5WlQ17VRmKOO6mngKCM8kXS3omzeXaxdZJMc2
        ddP9Y17o9G4+m/ApqWVxJuEmOC0sobfXLUhSmSDvgX5SquHBDu1IQs9CV9VWcD3D6nLXWGyzlTs
        6F29SeaVPXPQ2YP8Pw9cZK34css5qACtYZfb3piUes2ePcttAwTRiGu84d62EsS4Hig==
X-Google-Smtp-Source: ACHHUZ7gcnfVKIFjo3RdytTp/lnkLy8R9QaFd84Pn+fq40AnkmokSiaPzOjo+pqgRUe6fOIGDpdx5uclLQ88Y+w=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:ac20:0:b0:ba8:91c0:3c50 with SMTP id
 w32-20020a25ac20000000b00ba891c03c50mr6522488ybi.7.1684870198107; Tue, 23 May
 2023 12:29:58 -0700 (PDT)
Date:   Tue, 23 May 2023 19:29:46 +0000
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230523192749.1270992-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523192949.1271671-4-calvinwan@google.com>
Subject: [PATCH v2 4/7] common.h: move non-compat specific macros and
 functions from git-compat-util.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-compat-util.h has grown to a large and difficult to read file partly
because its set of functionality is overloaded. Besides being a
compatibility file that ensures Git's operation across different
operating systems, it has also become a dumping ground for commonly used
macros and static inline functions.

This commit separates out macros and static inline functions that are
compatible across operating systems into common.h. common.h is
reincluded back into git-compat-util.h so that other files do not also
have to include it. The eventual goal is for common.h to be separated
out into more reasonable boundaries, but for now this should be a good
first step towards that goal.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 common.h          | 410 ++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h | 402 +--------------------------------------------
 2 files changed, 412 insertions(+), 400 deletions(-)
 create mode 100644 common.h

diff --git a/common.h b/common.h
new file mode 100644
index 0000000000..0f164c1071
--- /dev/null
+++ b/common.h
@@ -0,0 +1,410 @@
+#ifndef COMMON_H
+#define COMMON_H
+
+#include "git-compat-util.h"
+#include "wrapper.h"
+
+/*
+ * ARRAY_SIZE - get the number of elements in a visible array
+ * @x: the array whose size you want.
+ *
+ * This does not work on pointers, or arrays declared as [], or
+ * function parameters.  With correct compiler support, such usage
+ * will cause a build error (see the build_assert_or_zero macro).
+ */
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + BARF_UNLESS_AN_ARRAY(x))
+
+#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
+
+#define maximum_signed_value_of_type(a) \
+    (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
+
+#define maximum_unsigned_value_of_type(a) \
+    (UINTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a)))
+
+/*
+ * Signed integer overflow is undefined in C, so here's a helper macro
+ * to detect if the sum of two integers will overflow.
+ *
+ * Requires: a >= 0, typeof(a) equals typeof(b)
+ */
+#define signed_add_overflows(a, b) \
+    ((b) > maximum_signed_value_of_type(a) - (a))
+
+#define unsigned_add_overflows(a, b) \
+    ((b) > maximum_unsigned_value_of_type(a) - (a))
+
+/*
+ * Returns true if the multiplication of "a" and "b" will
+ * overflow. The types of "a" and "b" must match and must be unsigned.
+ * Note that this macro evaluates "a" twice!
+ */
+#define unsigned_mult_overflows(a, b) \
+    ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
+
+/*
+ * Returns true if the left shift of "a" by "shift" bits will
+ * overflow. The type of "a" must be unsigned.
+ */
+#define unsigned_left_shift_overflows(a, shift) \
+    ((shift) < bitsizeof(a) && \
+     (a) > maximum_unsigned_value_of_type(a) >> (shift))
+
+#define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (bitsizeof(x) - (bits))))
+#define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))  /* checks if an integer has more than 1 bit set */
+
+#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
+
+/* Approximation of the length of the decimal representation of this type. */
+#define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
+
+/*
+ * If the string "str" begins with the string found in "prefix", return 1.
+ * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
+ * the string right after the prefix).
+ *
+ * Otherwise, return 0 and leave "out" untouched.
+ *
+ * Examples:
+ *
+ *   [extract branch name, fail if not a branch]
+ *   if (!skip_prefix(ref, "refs/heads/", &branch)
+ *	return -1;
+ *
+ *   [skip prefix if present, otherwise use whole string]
+ *   skip_prefix(name, "refs/heads/", &name);
+ */
+static inline int skip_prefix(const char *str, const char *prefix,
+			      const char **out)
+{
+	do {
+		if (!*prefix) {
+			*out = str;
+			return 1;
+		}
+	} while (*str++ == *prefix++);
+	return 0;
+}
+
+/*
+ * Like skip_prefix, but promises never to read past "len" bytes of the input
+ * buffer, and returns the remaining number of bytes in "out" via "outlen".
+ */
+static inline int skip_prefix_mem(const char *buf, size_t len,
+				  const char *prefix,
+				  const char **out, size_t *outlen)
+{
+	size_t prefix_len = strlen(prefix);
+	if (prefix_len <= len && !memcmp(buf, prefix, prefix_len)) {
+		*out = buf + prefix_len;
+		*outlen = len - prefix_len;
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * If buf ends with suffix, return 1 and subtract the length of the suffix
+ * from *len. Otherwise, return 0 and leave *len untouched.
+ */
+static inline int strip_suffix_mem(const char *buf, size_t *len,
+				   const char *suffix)
+{
+	size_t suflen = strlen(suffix);
+	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
+		return 0;
+	*len -= suflen;
+	return 1;
+}
+
+/*
+ * If str ends with suffix, return 1 and set *len to the size of the string
+ * without the suffix. Otherwise, return 0 and set *len to the size of the
+ * string.
+ *
+ * Note that we do _not_ NUL-terminate str to the new length.
+ */
+static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
+{
+	*len = strlen(str);
+	return strip_suffix_mem(str, len, suffix);
+}
+
+#define SWAP(a, b) do {						\
+	void *_swap_a_ptr = &(a);				\
+	void *_swap_b_ptr = &(b);				\
+	unsigned char _swap_buffer[sizeof(a)];			\
+	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
+	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
+	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
+	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
+} while (0)
+
+static inline size_t st_add(size_t a, size_t b)
+{
+	if (unsigned_add_overflows(a, b))
+		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a + b;
+}
+#define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
+#define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
+
+static inline size_t st_mult(size_t a, size_t b)
+{
+	if (unsigned_mult_overflows(a, b))
+		die("size_t overflow: %"PRIuMAX" * %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a * b;
+}
+
+static inline size_t st_sub(size_t a, size_t b)
+{
+	if (a < b)
+		die("size_t underflow: %"PRIuMAX" - %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a - b;
+}
+
+static inline size_t st_left_shift(size_t a, unsigned shift)
+{
+	if (unsigned_left_shift_overflows(a, shift))
+		die("size_t overflow: %"PRIuMAX" << %u",
+		    (uintmax_t)a, shift);
+	return a << shift;
+}
+
+static inline unsigned long cast_size_t_to_ulong(size_t a)
+{
+	if (a != (unsigned long)a)
+		die("object too large to read on this platform: %"
+		    PRIuMAX" is cut off to %lu",
+		    (uintmax_t)a, (unsigned long)a);
+	return (unsigned long)a;
+}
+
+static inline int cast_size_t_to_int(size_t a)
+{
+	if (a > INT_MAX)
+		die("number too large to represent as int on this platform: %"PRIuMAX,
+		    (uintmax_t)a);
+	return (int)a;
+}
+
+
+/*
+ * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
+ * that ptr is used twice, so don't pass e.g. ptr++.
+ */
+#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
+
+#define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
+#define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
+#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
+
+#define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
+	BARF_UNLESS_COPYABLE((dst), (src)))
+static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memcpy(dst, src, st_mult(size, n));
+}
+
+#define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
+	BARF_UNLESS_COPYABLE((dst), (src)))
+static inline void move_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memmove(dst, src, st_mult(size, n));
+}
+
+#define DUP_ARRAY(dst, src, n) do { \
+	size_t dup_array_n_ = (n); \
+	COPY_ARRAY(ALLOC_ARRAY((dst), dup_array_n_), (src), dup_array_n_); \
+} while (0)
+
+/*
+ * These functions help you allocate structs with flex arrays, and copy
+ * the data directly into the array. For example, if you had:
+ *
+ *   struct foo {
+ *     int bar;
+ *     char name[FLEX_ARRAY];
+ *   };
+ *
+ * you can do:
+ *
+ *   struct foo *f;
+ *   FLEX_ALLOC_MEM(f, name, src, len);
+ *
+ * to allocate a "foo" with the contents of "src" in the "name" field.
+ * The resulting struct is automatically zero'd, and the flex-array field
+ * is NUL-terminated (whether the incoming src buffer was or not).
+ *
+ * The FLEXPTR_* variants operate on structs that don't use flex-arrays,
+ * but do want to store a pointer to some extra data in the same allocated
+ * block. For example, if you have:
+ *
+ *   struct foo {
+ *     char *name;
+ *     int bar;
+ *   };
+ *
+ * you can do:
+ *
+ *   struct foo *f;
+ *   FLEXPTR_ALLOC_STR(f, name, src);
+ *
+ * and "name" will point to a block of memory after the struct, which will be
+ * freed along with the struct (but the pointer can be repointed anywhere).
+ *
+ * The *_STR variants accept a string parameter rather than a ptr/len
+ * combination.
+ *
+ * Note that these macros will evaluate the first parameter multiple
+ * times, and it must be assignable as an lvalue.
+ */
+#define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
+	size_t flex_array_len_ = (len); \
+	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
+	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \
+} while (0)
+#define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
+	size_t flex_array_len_ = (len); \
+	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
+	memcpy((x) + 1, (buf), flex_array_len_); \
+	(x)->ptrname = (void *)((x)+1); \
+} while(0)
+#define FLEX_ALLOC_STR(x, flexname, str) \
+	FLEX_ALLOC_MEM((x), flexname, (str), strlen(str))
+#define FLEXPTR_ALLOC_STR(x, ptrname, str) \
+	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
+
+static inline char *xstrdup_or_null(const char *str)
+{
+	return str ? xstrdup(str) : NULL;
+}
+
+static inline size_t xsize_t(off_t len)
+{
+	if (len < 0 || (uintmax_t) len > SIZE_MAX)
+		die("Cannot handle files this big");
+	return (size_t) len;
+}
+
+/*
+ * Like skip_prefix, but compare case-insensitively. Note that the comparison
+ * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
+ * locale-specific conversions).
+ */
+static inline int skip_iprefix(const char *str, const char *prefix,
+			       const char **out)
+{
+	do {
+		if (!*prefix) {
+			*out = str;
+			return 1;
+		}
+	} while (tolower(*str++) == tolower(*prefix++));
+	return 0;
+}
+
+/*
+ * Like skip_prefix_mem, but compare case-insensitively. Note that the
+ * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
+ * characters or locale-specific conversions).
+ */
+static inline int skip_iprefix_mem(const char *buf, size_t len,
+				   const char *prefix,
+				   const char **out, size_t *outlen)
+{
+	do {
+		if (!*prefix) {
+			*out = buf;
+			*outlen = len;
+			return 1;
+		}
+	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
+	return 0;
+}
+
+static inline int strtoul_ui(char const *s, int base, unsigned int *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s || (unsigned int) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
+static inline int strtol_i(char const *s, int base, int *result)
+{
+	long ul;
+	char *p;
+
+	errno = 0;
+	ul = strtol(s, &p, base);
+	if (errno || *p || p == s || (int) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
+static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
+			      size_t nmatch, regmatch_t pmatch[], int eflags)
+{
+	assert(nmatch > 0 && pmatch);
+	pmatch[0].rm_so = 0;
+	pmatch[0].rm_eo = size;
+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
+}
+
+/*
+ * Our code often opens a path to an optional file, to work on its
+ * contents when we can successfully open it.  We can ignore a failure
+ * to open if such an optional file does not exist, but we do want to
+ * report a failure in opening for other reasons (e.g. we got an I/O
+ * error, or the file is there, but we lack the permission to open).
+ *
+ * Call this function after seeing an error from open() or fopen() to
+ * see if the errno indicates a missing file that we can safely ignore.
+ */
+static inline int is_missing_file_error(int errno_)
+{
+	return (errno_ == ENOENT || errno_ == ENOTDIR);
+}
+
+/*
+ * container_of - Get the address of an object containing a field.
+ *
+ * @ptr: pointer to the field.
+ * @type: type of the object.
+ * @member: name of the field within the object.
+ */
+#define container_of(ptr, type, member) \
+	((type *) ((char *)(ptr) - offsetof(type, member)))
+
+/*
+ * helper function for `container_of_or_null' to avoid multiple
+ * evaluation of @ptr
+ */
+static inline void *container_of_or_null_offset(void *ptr, size_t offset)
+{
+	return ptr ? (char *)ptr - offset : NULL;
+}
+
+/*
+ * like `container_of', but allows returned value to be NULL
+ */
+#define container_of_or_null(ptr, type, member) \
+	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
+
+
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 9d3c21acbb..f73c8727d1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -106,51 +106,6 @@ struct strbuf;
 	BUILD_ASSERT_OR_ZERO(0 ? ((*(dst) = *(src)), 0) : \
 				 sizeof(*(dst)) == sizeof(*(src)))
 #endif
-/*
- * ARRAY_SIZE - get the number of elements in a visible array
- * @x: the array whose size you want.
- *
- * This does not work on pointers, or arrays declared as [], or
- * function parameters.  With correct compiler support, such usage
- * will cause a build error (see the build_assert_or_zero macro).
- */
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + BARF_UNLESS_AN_ARRAY(x))
-
-#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
-
-#define maximum_signed_value_of_type(a) \
-    (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
-
-#define maximum_unsigned_value_of_type(a) \
-    (UINTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a)))
-
-/*
- * Signed integer overflow is undefined in C, so here's a helper macro
- * to detect if the sum of two integers will overflow.
- *
- * Requires: a >= 0, typeof(a) equals typeof(b)
- */
-#define signed_add_overflows(a, b) \
-    ((b) > maximum_signed_value_of_type(a) - (a))
-
-#define unsigned_add_overflows(a, b) \
-    ((b) > maximum_unsigned_value_of_type(a) - (a))
-
-/*
- * Returns true if the multiplication of "a" and "b" will
- * overflow. The types of "a" and "b" must match and must be unsigned.
- * Note that this macro evaluates "a" twice!
- */
-#define unsigned_mult_overflows(a, b) \
-    ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
-
-/*
- * Returns true if the left shift of "a" by "shift" bits will
- * overflow. The type of "a" must be unsigned.
- */
-#define unsigned_left_shift_overflows(a, shift) \
-    ((shift) < bitsizeof(a) && \
-     (a) > maximum_unsigned_value_of_type(a) >> (shift))
 
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
@@ -158,14 +113,6 @@ struct strbuf;
 #define TYPEOF(x)
 #endif
 
-#define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (bitsizeof(x) - (bits))))
-#define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))  /* checks if an integer has more than 1 bit set */
-
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
-
-/* Approximation of the length of the decimal representation of this type. */
-#define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
-
 #ifdef __MINGW64__
 #define _POSIX_C_SOURCE 1
 #elif defined(__sun__)
@@ -677,88 +624,6 @@ void set_warn_routine(report_fn routine);
 report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
-/*
- * If the string "str" begins with the string found in "prefix", return 1.
- * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
- * the string right after the prefix).
- *
- * Otherwise, return 0 and leave "out" untouched.
- *
- * Examples:
- *
- *   [extract branch name, fail if not a branch]
- *   if (!skip_prefix(ref, "refs/heads/", &branch)
- *	return -1;
- *
- *   [skip prefix if present, otherwise use whole string]
- *   skip_prefix(name, "refs/heads/", &name);
- */
-static inline int skip_prefix(const char *str, const char *prefix,
-			      const char **out)
-{
-	do {
-		if (!*prefix) {
-			*out = str;
-			return 1;
-		}
-	} while (*str++ == *prefix++);
-	return 0;
-}
-
-/*
- * Like skip_prefix, but promises never to read past "len" bytes of the input
- * buffer, and returns the remaining number of bytes in "out" via "outlen".
- */
-static inline int skip_prefix_mem(const char *buf, size_t len,
-				  const char *prefix,
-				  const char **out, size_t *outlen)
-{
-	size_t prefix_len = strlen(prefix);
-	if (prefix_len <= len && !memcmp(buf, prefix, prefix_len)) {
-		*out = buf + prefix_len;
-		*outlen = len - prefix_len;
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * If buf ends with suffix, return 1 and subtract the length of the suffix
- * from *len. Otherwise, return 0 and leave *len untouched.
- */
-static inline int strip_suffix_mem(const char *buf, size_t *len,
-				   const char *suffix)
-{
-	size_t suflen = strlen(suffix);
-	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
-		return 0;
-	*len -= suflen;
-	return 1;
-}
-
-/*
- * If str ends with suffix, return 1 and set *len to the size of the string
- * without the suffix. Otherwise, return 0 and set *len to the size of the
- * string.
- *
- * Note that we do _not_ NUL-terminate str to the new length.
- */
-static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
-{
-	*len = strlen(str);
-	return strip_suffix_mem(str, len, suffix);
-}
-
-#define SWAP(a, b) do {						\
-	void *_swap_a_ptr = &(a);				\
-	void *_swap_b_ptr = &(b);				\
-	unsigned char _swap_buffer[sizeof(a)];			\
-	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
-	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
-	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
-	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
-} while (0)
-
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
@@ -964,57 +829,6 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 int git_atexit(void (*handler)(void));
 #endif
 
-static inline size_t st_add(size_t a, size_t b)
-{
-	if (unsigned_add_overflows(a, b))
-		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
-		    (uintmax_t)a, (uintmax_t)b);
-	return a + b;
-}
-#define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
-#define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
-
-static inline size_t st_mult(size_t a, size_t b)
-{
-	if (unsigned_mult_overflows(a, b))
-		die("size_t overflow: %"PRIuMAX" * %"PRIuMAX,
-		    (uintmax_t)a, (uintmax_t)b);
-	return a * b;
-}
-
-static inline size_t st_sub(size_t a, size_t b)
-{
-	if (a < b)
-		die("size_t underflow: %"PRIuMAX" - %"PRIuMAX,
-		    (uintmax_t)a, (uintmax_t)b);
-	return a - b;
-}
-
-static inline size_t st_left_shift(size_t a, unsigned shift)
-{
-	if (unsigned_left_shift_overflows(a, shift))
-		die("size_t overflow: %"PRIuMAX" << %u",
-		    (uintmax_t)a, shift);
-	return a << shift;
-}
-
-static inline unsigned long cast_size_t_to_ulong(size_t a)
-{
-	if (a != (unsigned long)a)
-		die("object too large to read on this platform: %"
-		    PRIuMAX" is cut off to %lu",
-		    (uintmax_t)a, (unsigned long)a);
-	return (unsigned long)a;
-}
-
-static inline int cast_size_t_to_int(size_t a)
-{
-	if (a > INT_MAX)
-		die("number too large to represent as int on this platform: %"PRIuMAX,
-		    (uintmax_t)a);
-	return (int)a;
-}
-
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
@@ -1046,177 +860,12 @@ static inline int cast_size_t_to_int(size_t a)
 # define xalloca_free(p)    (free(p))
 #endif
 
-/*
- * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
- * that ptr is used twice, so don't pass e.g. ptr++.
- */
-#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
-
-#define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
-#define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
-#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
-
-#define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
-	BARF_UNLESS_COPYABLE((dst), (src)))
-static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
-{
-	if (n)
-		memcpy(dst, src, st_mult(size, n));
-}
-
-#define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
-	BARF_UNLESS_COPYABLE((dst), (src)))
-static inline void move_array(void *dst, const void *src, size_t n, size_t size)
-{
-	if (n)
-		memmove(dst, src, st_mult(size, n));
-}
-
-#define DUP_ARRAY(dst, src, n) do { \
-	size_t dup_array_n_ = (n); \
-	COPY_ARRAY(ALLOC_ARRAY((dst), dup_array_n_), (src), dup_array_n_); \
-} while (0)
-
-/*
- * These functions help you allocate structs with flex arrays, and copy
- * the data directly into the array. For example, if you had:
- *
- *   struct foo {
- *     int bar;
- *     char name[FLEX_ARRAY];
- *   };
- *
- * you can do:
- *
- *   struct foo *f;
- *   FLEX_ALLOC_MEM(f, name, src, len);
- *
- * to allocate a "foo" with the contents of "src" in the "name" field.
- * The resulting struct is automatically zero'd, and the flex-array field
- * is NUL-terminated (whether the incoming src buffer was or not).
- *
- * The FLEXPTR_* variants operate on structs that don't use flex-arrays,
- * but do want to store a pointer to some extra data in the same allocated
- * block. For example, if you have:
- *
- *   struct foo {
- *     char *name;
- *     int bar;
- *   };
- *
- * you can do:
- *
- *   struct foo *f;
- *   FLEXPTR_ALLOC_STR(f, name, src);
- *
- * and "name" will point to a block of memory after the struct, which will be
- * freed along with the struct (but the pointer can be repointed anywhere).
- *
- * The *_STR variants accept a string parameter rather than a ptr/len
- * combination.
- *
- * Note that these macros will evaluate the first parameter multiple
- * times, and it must be assignable as an lvalue.
- */
-#define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
-	size_t flex_array_len_ = (len); \
-	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
-	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \
-} while (0)
-#define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
-	size_t flex_array_len_ = (len); \
-	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
-	memcpy((x) + 1, (buf), flex_array_len_); \
-	(x)->ptrname = (void *)((x)+1); \
-} while(0)
-#define FLEX_ALLOC_STR(x, flexname, str) \
-	FLEX_ALLOC_MEM((x), flexname, (str), strlen(str))
-#define FLEXPTR_ALLOC_STR(x, ptrname, str) \
-	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
-
-static inline char *xstrdup_or_null(const char *str)
-{
-	return str ? xstrdup(str) : NULL;
-}
-
-static inline size_t xsize_t(off_t len)
-{
-	if (len < 0 || (uintmax_t) len > SIZE_MAX)
-		die("Cannot handle files this big");
-	return (size_t) len;
-}
-
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
 
 #include "sane-ctype.h"
 
-/*
- * Like skip_prefix, but compare case-insensitively. Note that the comparison
- * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
- * locale-specific conversions).
- */
-static inline int skip_iprefix(const char *str, const char *prefix,
-			       const char **out)
-{
-	do {
-		if (!*prefix) {
-			*out = str;
-			return 1;
-		}
-	} while (tolower(*str++) == tolower(*prefix++));
-	return 0;
-}
-
-/*
- * Like skip_prefix_mem, but compare case-insensitively. Note that the
- * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
- * characters or locale-specific conversions).
- */
-static inline int skip_iprefix_mem(const char *buf, size_t len,
-				   const char *prefix,
-				   const char **out, size_t *outlen)
-{
-	do {
-		if (!*prefix) {
-			*out = buf;
-			*outlen = len;
-			return 1;
-		}
-	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
-	return 0;
-}
-
-static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-{
-	unsigned long ul;
-	char *p;
-
-	errno = 0;
-	/* negative values would be accepted by strtoul */
-	if (strchr(s, '-'))
-		return -1;
-	ul = strtoul(s, &p, base);
-	if (errno || *p || p == s || (unsigned int) ul != ul)
-		return -1;
-	*result = ul;
-	return 0;
-}
-
-static inline int strtol_i(char const *s, int base, int *result)
-{
-	long ul;
-	char *p;
-
-	errno = 0;
-	ul = strtol(s, &p, base);
-	if (errno || *p || p == s || (int) ul != ul)
-		return -1;
-	*result = ul;
-	return 0;
-}
-
 void git_stable_qsort(void *base, size_t nmemb, size_t size,
 		      int(*compar)(const void *, const void *));
 #ifdef INTERNAL_QSORT
@@ -1249,15 +898,6 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
 
-static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
-			      size_t nmatch, regmatch_t pmatch[], int eflags)
-{
-	assert(nmatch > 0 && pmatch);
-	pmatch[0].rm_so = 0;
-	pmatch[0].rm_eo = size;
-	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
-}
-
 #ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 int git_regcomp(regex_t *preg, const char *pattern, int cflags);
 #define regcomp git_regcomp
@@ -1366,21 +1006,6 @@ int git_access(const char *path, int mode);
 # endif
 #endif
 
-/*
- * Our code often opens a path to an optional file, to work on its
- * contents when we can successfully open it.  We can ignore a failure
- * to open if such an optional file does not exist, but we do want to
- * report a failure in opening for other reasons (e.g. we got an I/O
- * error, or the file is there, but we lack the permission to open).
- *
- * Call this function after seeing an error from open() or fopen() to
- * see if the errno indicates a missing file that we can safely ignore.
- */
-static inline int is_missing_file_error(int errno_)
-{
-	return (errno_ == ENOENT || errno_ == ENOTDIR);
-}
-
 int cmd_main(int, const char **);
 
 /*
@@ -1422,37 +1047,14 @@ int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
 		uLong *sourceLen);
 #endif
 
+#include "common.h"
+
 /*
  * This include must come after system headers, since it introduces macros that
  * replace system names.
  */
 #include "banned.h"
 
-/*
- * container_of - Get the address of an object containing a field.
- *
- * @ptr: pointer to the field.
- * @type: type of the object.
- * @member: name of the field within the object.
- */
-#define container_of(ptr, type, member) \
-	((type *) ((char *)(ptr) - offsetof(type, member)))
-
-/*
- * helper function for `container_of_or_null' to avoid multiple
- * evaluation of @ptr
- */
-static inline void *container_of_or_null_offset(void *ptr, size_t offset)
-{
-	return ptr ? (char *)ptr - offset : NULL;
-}
-
-/*
- * like `container_of', but allows returned value to be NULL
- */
-#define container_of_or_null(ptr, type, member) \
-	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
-
 /*
  * like offsetof(), but takes a pointer to a variable of type which
  * contains @member, instead of a specified type.
-- 
2.40.1.698.g37aff9b760-goog

