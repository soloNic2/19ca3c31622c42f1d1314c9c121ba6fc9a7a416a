Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35104C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjFFFUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjFFFTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:19:53 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE47E55
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:19:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1ECA63200AD8;
        Tue,  6 Jun 2023 01:19:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Jun 2023 01:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686028789; x=1686115189; bh=Jx
        gsPn1P0tf3QT4DMDo7IbSR4C79qdDsKbbRdKilBH4=; b=Z2wEZKJr9yBZbVdXwA
        qGiLO19GpgomFB+5Mp2x1OI1asOAYoWtppKo3z5t8OjZAPUCgd9eh77xE9dhH8S3
        aeruLxzJ9qdns/3Vv+3gQTMEhuFr1szeT2RBreYKDjV8Y5FgtamGNmZgNk6IhqZe
        /mylCqsKC1s0R4NUvYxJIM58wYNI3dF6Vr/mb3MGaN+3sD5gLGLlcz7L97q0zy46
        sNkQUZn9uNxLCU5ppKXmuL/hxOvi9D5pHFTEy7aiJdqw2E2DnlRs4REbreGb1Nvn
        gVW7gN9KRReIdT1b2v48h3Xu0/UqJ6fsxld1Z108rpYVAaA88+/+1ZSudoO6hEE/
        Ipag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686028789; x=1686115189; bh=JxgsPn1P0tf3Q
        T4DMDo7IbSR4C79qdDsKbbRdKilBH4=; b=qi7izz2ff5pEJC8+xu8Jd+NqA4owd
        WP5yNaL4L/vu0gut73gV+HQKr2Zn/0t4u8MAltb551/tVYv9yPeOz2Y/GMStMzcK
        arND8CaqfDcPZ41ias0jMm4c0mXX2zx1AYAlnxz2wsUpy53rBFZSXZ1/inlFK2ZQ
        9jK7F2n//kF0a+ps3YIJ0wP5eNAsO1NXlOkHXQq10nsp7tdsUEIW13jjQMG+fgEM
        MbQnwhfSKxGsmNpam6ae0op22PHiRXRw7YOTRCzXrj814sLjtqXeJZ5GCI6lnCbC
        aBgWqlqDcNs8oFFrtO5G3ZJ7TCCXlHEdUVfo00X+ppWW6N8rlnFJnMv1w==
X-ME-Sender: <xms:9cF-ZJdhccNng7pnhAeMZd3WpHColrCqEO002TDffD3OKxy2onuaNA>
    <xme:9cF-ZHNTHka1tQtjwGAGSySTqHjZ2upj9-S2Sy3mIlQ5bOhj8RwDSTNyQ_xfeFlyF
    cbVG8bIn2Xn6BT2Dw>
X-ME-Received: <xmr:9cF-ZCgyR7niLoOv0UUbtY7L1VAd-Yua-mRnVVdKgFDx22Rzr32LZNCQWtjEi2tuosBqLek8LMAe-qXiI8RqYRgcX_LWIcsXbj8jNrWW3Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9cF-ZC-3IwyrXdAkQ_cqSxPPOteaIRrzTYtsinpySmc4KUujdyQWCA>
    <xmx:9cF-ZFv9YB_tFRIPiLF0LIO3P91Gyn_3MSTqT6kRa0rRtHHiyg1TTQ>
    <xmx:9cF-ZBE-tno-eSOdqbdkAMZCw2Z7ILh7sNGYM8MuuBhYVWj-QnCUIw>
    <xmx:9cF-ZNL0J2_KVdvvjilMJFvWV4FKJ7YvNgrR8_kLlFy6sOmDlDF3bQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:19:48 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2f7046e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:18:44 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:19:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] cat-file: introduce option to delimit input and
 output with NUL
Message-ID: <79ed618c845fae3f06b6ff4b3ade58e1fcccb758.1686028409.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
 <cover.1686028409.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HXBSxkbXXprPwElw"
Content-Disposition: inline
In-Reply-To: <cover.1686028409.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HXBSxkbXXprPwElw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with
`-z`, 2022-07-22), we have introduced a new mode to read the input via
NUL-delimited records instead of newline-delimited records. This allows
the user to query for revisions that have newlines in their path
component. While unusual, such queries are perfectly valid and thus it
is clear that we should be able to support them properly.

Unfortunately, the commit only changed the input to be NUL-delimited,
but didn't change the output at the same time. While this is fine for
queries that are processed successfully, it is less so for queries that
aren't. In the case of missing commits for example the result can become
entirely unparsable:

```
$ printf "7ce4f05bae8120d9fa258e854a8669f6ea9cb7b1 blob 10\n1234567890\n\n\=
commit000" |
    git cat-file --batch -z
7ce4f05bae8120d9fa258e854a8669f6ea9cb7b1 blob 10
1234567890

commit missing
```

This is of course a crafted query that is intentionally gaming the
deficiency, but more benign queries that contain newlines would have
similar problems.

Ideally, we should have also changed the output to be NUL-delimited when
`-z` is specified to avoid this problem. As the input is NUL-delimited,
it is clear that the output in this case cannot ever contain NUL
characters by itself. Furthermore, Git does not allow NUL characters in
revisions anyway, further stressing the point that using NUL-delimited
output is safe. The only exception is of course the object data itself,
but as git-cat-file(1) prints the size of the object data clients should
read until that specified size has been consumed.

But even though `-z` has only been introduced a few releases ago in Git
v2.38.0, changing the output format retroactively to also NUL-delimit
output would be a backwards incompatible change. And while one could
make the argument that the output is inherently broken already, we need
to assume that there are existing users out there that use it just fine
given that revisions containing newlines are quite exotic.

Instead, introduce a new option `-Z` that switches to NUL-delimited
input and output. While this new option could arguably only switch the
output format to be NUL-delimited, the consequence would be that users
have to always specify both `-z` and `-Z` when the input may contain
newlines. On the other hand, if the user knows that there never will be
newlines in the input, they don't have to use either of those options.
There is thus no usecase that would warrant treating input and output
format separately, which is why we instead opt to "do the right thing"
and have `-Z` mean to NUL-terminate both formats.

The old `-z` option is marked as deprecated with a hint that its output
may become unparsable. It is thus hidden both from the synopsis as well
as the command's help output.

Co-authored-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.txt |  15 +++-
 builtin/cat-file.c             |  57 +++++++++------
 t/t1006-cat-file.sh            | 123 ++++++++++++++++++++++++---------
 3 files changed, 139 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 411de2e27d..0e4936d182 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git cat-file' (-t | -s) [--allow-unknown-type] <object>
 'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-ob=
jects]
 	     [--buffer] [--follow-symlinks] [--unordered]
-	     [--textconv | --filters] [-z]
+	     [--textconv | --filters] [-Z]
 'git cat-file' (--textconv | --filters)
 	     [<rev>:<path|tree-ish> | --path=3D<path|tree-ish> <rev>]
=20
@@ -243,10 +243,16 @@ respectively print:
 	/etc/passwd
 --
=20
+-Z::
+	Only meaningful with `--batch`, `--batch-check`, or
+	`--batch-command`; input and output is NUL-delimited instead of
+	newline-delimited.
+
 -z::
 	Only meaningful with `--batch`, `--batch-check`, or
 	`--batch-command`; input is NUL-delimited instead of
-	newline-delimited.
+	newline-delimited. This option is deprecated in favor of
+	`-Z` as the output can otherwise be ambiguous.
=20
=20
 OUTPUT
@@ -384,6 +390,11 @@ notdir SP <size> LF
 is printed when, during symlink resolution, a file is used as a
 directory name.
=20
+Alternatively, when `-Z` is passed, the line feeds in any of the above exa=
mples
+are replaced with NUL terminators. This ensures that output will be parsab=
le if
+the output itself would contain a linefeed and is thus recommended for
+scripting purposes.
+
 CAVEATS
 -------
=20
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 001dcb24d6..e5f72229df 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -43,6 +43,7 @@ struct batch_options {
 	int unordered;
 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
 	char input_delim;
+	char output_delim;
 	const char *format;
 };
=20
@@ -437,11 +438,12 @@ static void print_object_or_die(struct batch_options =
*opt, struct expand_data *d
 	}
 }
=20
-static void print_default_format(struct strbuf *scratch, struct expand_dat=
a *data)
+static void print_default_format(struct strbuf *scratch, struct expand_dat=
a *data,
+				 struct batch_options *opt)
 {
-	strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+	strbuf_addf(scratch, "%s %s %"PRIuMAX"%c", oid_to_hex(&data->oid),
 		    type_name(data->type),
-		    (uintmax_t)data->size);
+		    (uintmax_t)data->size, opt->output_delim);
 }
=20
 /*
@@ -470,8 +472,8 @@ static void batch_object_write(const char *obj_name,
 						       &data->oid, &data->info,
 						       OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
-			printf("%s missing\n",
-			       obj_name ? obj_name : oid_to_hex(&data->oid));
+			printf("%s missing%c",
+			       obj_name ? obj_name : oid_to_hex(&data->oid), opt->output_delim);
 			fflush(stdout);
 			return;
 		}
@@ -492,17 +494,17 @@ static void batch_object_write(const char *obj_name,
 	strbuf_reset(scratch);
=20
 	if (!opt->format) {
-		print_default_format(scratch, data);
+		print_default_format(scratch, data, opt);
 	} else {
 		strbuf_expand(scratch, opt->format, expand_format, data);
-		strbuf_addch(scratch, '\n');
+		strbuf_addch(scratch, opt->output_delim);
 	}
=20
 	batch_write(opt, scratch->buf, scratch->len);
=20
 	if (opt->batch_mode =3D=3D BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
-		batch_write(opt, "\n", 1);
+		batch_write(opt, &opt->output_delim, 1);
 	}
 }
=20
@@ -520,22 +522,25 @@ static void batch_one_object(const char *obj_name,
 	if (result !=3D FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
-			printf("%s missing\n", obj_name);
+			printf("%s missing%c", obj_name, opt->output_delim);
 			break;
 		case SHORT_NAME_AMBIGUOUS:
-			printf("%s ambiguous\n", obj_name);
+			printf("%s ambiguous%c", obj_name, opt->output_delim);
 			break;
 		case DANGLING_SYMLINK:
-			printf("dangling %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
+			printf("dangling %"PRIuMAX"%c%s%c",
+			       (uintmax_t)strlen(obj_name),
+			       opt->output_delim, obj_name, opt->output_delim);
 			break;
 		case SYMLINK_LOOP:
-			printf("loop %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
+			printf("loop %"PRIuMAX"%c%s%c",
+			       (uintmax_t)strlen(obj_name),
+			       opt->output_delim, obj_name, opt->output_delim);
 			break;
 		case NOT_DIR:
-			printf("notdir %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
+			printf("notdir %"PRIuMAX"%c%s%c",
+			       (uintmax_t)strlen(obj_name),
+			       opt->output_delim, obj_name, opt->output_delim);
 			break;
 		default:
 			BUG("unknown get_sha1_with_context result %d\n",
@@ -547,9 +552,9 @@ static void batch_one_object(const char *obj_name,
 	}
=20
 	if (ctx.mode =3D=3D 0) {
-		printf("symlink %"PRIuMAX"\n%s\n",
+		printf("symlink %"PRIuMAX"%c%s%c",
 		       (uintmax_t)ctx.symlink_path.len,
-		       ctx.symlink_path.buf);
+		       opt->output_delim, ctx.symlink_path.buf, opt->output_delim);
 		fflush(stdout);
 		return;
 	}
@@ -913,6 +918,7 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 	struct batch_options batch =3D {0};
 	int unknown_type =3D 0;
 	int input_nul_terminated =3D 0;
+	int nul_terminated =3D 0;
=20
 	const char * const usage[] =3D {
 		N_("git cat-file <type> <object>"),
@@ -920,7 +926,7 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-al=
l-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters] [-z]"),
+		   "             [--textconv | --filters] [-Z]"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=3D<path|tree-ish> <rev>=
]"),
 		NULL
@@ -949,7 +955,9 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
-		OPT_BOOL('z', NULL, &input_nul_terminated, N_("stdin is NUL-terminated")=
),
+		OPT_BOOL_F('z', NULL, &input_nul_terminated, N_("stdin is NUL-terminated=
"),
+			PARSE_OPT_HIDDEN),
+		OPT_BOOL('Z', NULL, &nul_terminated, N_("stdin and stdout is NUL-termina=
ted")),
 		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
 			N_("read commands from stdin"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
@@ -1011,8 +1019,15 @@ int cmd_cat_file(int argc, const char **argv, const =
char *prefix)
 	else if (input_nul_terminated)
 		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
 			       "-z");
+	else if (nul_terminated)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "-Z");
=20
-	batch.input_delim =3D input_nul_terminated ? '\0' : '\n';
+	batch.input_delim =3D batch.output_delim =3D '\n';
+	if (input_nul_terminated)
+		batch.input_delim =3D '\0';
+	if (nul_terminated)
+		batch.input_delim =3D batch.output_delim =3D '\0';
=20
 	/* Batch defaults */
 	if (batch.buffer_output < 0)
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7b985cfded..d73a0be1b9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -89,7 +89,8 @@ done
 for opt in --buffer \
 	--follow-symlinks \
 	--batch-all-objects \
-	-z
+	-z \
+	-Z
 do
 	test_expect_success "usage: bad option combination: $opt without batch mo=
de" '
 		test_incompatible_usage git cat-file $opt &&
@@ -392,17 +393,18 @@ deadbeef
=20
 "
=20
-batch_output=3D"$hello_sha1 blob $hello_size
-$hello_content
-$commit_sha1 commit $commit_size
-$commit_content
-$tag_sha1 tag $tag_size
-$tag_content
-deadbeef missing
- missing"
+printf "%s\0" \
+	"$hello_sha1 blob $hello_size" \
+	"$hello_content" \
+	"$commit_sha1 commit $commit_size" \
+	"$commit_content" \
+	"$tag_sha1 tag $tag_size" \
+	"$tag_content" \
+	"deadbeef missing" \
+	" missing" >batch_output
=20
 test_expect_success '--batch with multiple sha1s gives correct format' '
-	echo "$batch_output" >expect &&
+	tr "\0" "\n" <batch_output >expect &&
 	echo_without_newline "$batch_input" >in &&
 	git cat-file --batch <in >actual &&
 	test_cmp expect actual
@@ -410,11 +412,17 @@ test_expect_success '--batch with multiple sha1s give=
s correct format' '
=20
 test_expect_success '--batch, -z with multiple sha1s gives correct format'=
 '
 	echo_without_newline_nul "$batch_input" >in &&
-	echo "$batch_output" >expect &&
+	tr "\0" "\n" <batch_output >expect &&
 	git cat-file --batch -z <in >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success '--batch, -Z with multiple sha1s gives correct format'=
 '
+	echo_without_newline_nul "$batch_input" >in &&
+	git cat-file --batch -Z <in >actual &&
+	test_cmp batch_output actual
+'
+
 batch_check_input=3D"$hello_sha1
 $tree_sha1
 $commit_sha1
@@ -423,40 +431,55 @@ deadbeef
=20
 "
=20
-batch_check_output=3D"$hello_sha1 blob $hello_size
-$tree_sha1 tree $tree_size
-$commit_sha1 commit $commit_size
-$tag_sha1 tag $tag_size
-deadbeef missing
- missing"
+printf "%s\0" \
+	"$hello_sha1 blob $hello_size" \
+	"$tree_sha1 tree $tree_size" \
+	"$commit_sha1 commit $commit_size" \
+	"$tag_sha1 tag $tag_size" \
+	"deadbeef missing" \
+	" missing" >batch_check_output
=20
 test_expect_success "--batch-check with multiple sha1s gives correct forma=
t" '
-	echo "$batch_check_output" >expect &&
+	tr "\0" "\n" <batch_check_output >expect &&
 	echo_without_newline "$batch_check_input" >in &&
 	git cat-file --batch-check <in >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success "--batch-check, -z with multiple sha1s gives correct f=
ormat" '
-	echo "$batch_check_output" >expect &&
+	tr "\0" "\n" <batch_check_output >expect &&
 	echo_without_newline_nul "$batch_check_input" >in &&
 	git cat-file --batch-check -z <in >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
+test_expect_success "--batch-check, -Z with multiple sha1s gives correct f=
ormat" '
+	echo_without_newline_nul "$batch_check_input" >in &&
+	git cat-file --batch-check -Z <in >actual &&
+	test_cmp batch_check_output actual
+'
+
+test_expect_success FUNNYNAMES 'setup with newline in input' '
 	touch -- "newline${LF}embedded" &&
 	git add -- "newline${LF}embedded" &&
 	git commit -m "file with newline embedded" &&
 	test_tick &&
=20
-	printf "HEAD:newline${LF}embedded" >in &&
-	git cat-file --batch-check -z <in >actual &&
+	printf "HEAD:newline${LF}embedded" >in
+'
=20
+test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
+	git cat-file --batch-check -z <in >actual &&
 	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
 	test_cmp expect actual
 '
=20
+test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
+	git cat-file --batch-check -Z <in >actual &&
+	printf "%s\0" "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expe=
ct &&
+	test_cmp expect actual
+'
+
 batch_command_multiple_info=3D"info $hello_sha1
 info $tree_sha1
 info $commit_sha1
@@ -480,7 +503,13 @@ test_expect_success '--batch-command with multiple inf=
o calls gives correct form
 	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
 	git cat-file --batch-command --buffer -z <in >actual &&
=20
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
+	tr "\n" "\0" <expect >expect_nul &&
+	git cat-file --batch-command --buffer -Z <in >actual &&
+
+	test_cmp expect_nul actual
 '
=20
 batch_command_multiple_contents=3D"contents $hello_sha1
@@ -490,15 +519,15 @@ contents deadbeef
 flush"
=20
 test_expect_success '--batch-command with multiple command calls gives cor=
rect format' '
-	cat >expect <<-EOF &&
-	$hello_sha1 blob $hello_size
-	$hello_content
-	$commit_sha1 commit $commit_size
-	$commit_content
-	$tag_sha1 tag $tag_size
-	$tag_content
-	deadbeef missing
-	EOF
+	printf "%s\0" \
+		"$hello_sha1 blob $hello_size" \
+		"$hello_content" \
+		"$commit_sha1 commit $commit_size" \
+		"$commit_content" \
+		"$tag_sha1 tag $tag_size" \
+		"$tag_content" \
+		"deadbeef missing" >expect_nul &&
+	tr "\0" "\n" <expect_nul >expect &&
=20
 	echo "$batch_command_multiple_contents" >in &&
 	git cat-file --batch-command --buffer <in >actual &&
@@ -508,7 +537,12 @@ test_expect_success '--batch-command with multiple com=
mand calls gives correct f
 	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
 	git cat-file --batch-command --buffer -z <in >actual &&
=20
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
+	git cat-file --batch-command --buffer -Z <in >actual &&
+
+	test_cmp expect_nul actual
 '
=20
 test_expect_success 'setup blobs which are likely to delta' '
@@ -848,6 +882,13 @@ test_expect_success 'git cat-file --batch-check --foll=
ow-symlinks works for brok
 	test_cmp expect actual
 '
=20
+test_expect_success 'git cat-file --batch-check --follow-symlinks -Z works=
 for broken in-repo, same-dir links' '
+	printf "HEAD:broken-same-dir-link\0" >in &&
+	printf "dangling 25\0HEAD:broken-same-dir-link\0" >expect &&
+	git cat-file --batch-check --follow-symlinks -Z <in >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git cat-file --batch-check --follow-symlinks works fo=
r same-dir links-to-links' '
 	echo HEAD:link-to-link | git cat-file --batch-check --follow-symlinks >ac=
tual &&
 	test_cmp found actual
@@ -862,6 +903,15 @@ test_expect_success 'git cat-file --batch-check --foll=
ow-symlinks works for pare
 	test_cmp expect actual
 '
=20
+test_expect_success 'git cat-file --batch-check --follow-symlinks -Z works=
 for parent-dir links' '
+	echo HEAD:dir/parent-dir-link | git cat-file --batch-check --follow-symli=
nks >actual &&
+	test_cmp found actual &&
+	printf "notdir 29\0HEAD:dir/parent-dir-link/nope\0" >expect &&
+	printf "HEAD:dir/parent-dir-link/nope\0" >in &&
+	git cat-file --batch-check --follow-symlinks -Z <in >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git cat-file --batch-check --follow-symlinks works fo=
r .. links' '
 	echo dangling 22 >expect &&
 	echo HEAD:dir/link-dir/nope >>expect &&
@@ -976,6 +1026,13 @@ test_expect_success 'git cat-file --batch-check --fol=
low-symlink breaks loops' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'git cat-file --batch-check --follow-symlink -Z breaks=
 loops' '
+	printf "loop 10\0HEAD:loop1\0" >expect &&
+	printf "HEAD:loop1\0" >in &&
+	git cat-file --batch-check --follow-symlinks -Z <in >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git cat-file --batch --follow-symlink returns correct=
 sha and mode' '
 	echo HEAD:morx | git cat-file --batch >expect &&
 	echo HEAD:morx | git cat-file --batch --follow-symlinks >actual &&
--=20
2.41.0


--HXBSxkbXXprPwElw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+wfEACgkQVbJhu7ck
PpTgig/+NQRpWjLWUy800PSPI0j9x7uT+1mM8q0nt4RwmooMUqZ/d0m8WxEuH95m
pKr4k056kX6UNdGI3Jof1G2fuef7ub8wwBn7bVU2s+1y1MLCwCzWwMlTFXuKub0h
7T4MgTBzBLZ60Wv71TQYRtdUpOU+Wc3jeXFXKRoi1g9YRF92aGIVElz6u0nSxMVq
mUlzmNd7VZpj69MnqibJITvn2lHUJRqidIlvr1SssvBTkSoIbhZaJNSd/IIeThYH
Jh6Hjo0ihbrGxFQLYHFlKxzVoj/BFaP0MTvEkLLQX6Vw7cFyzyU5DP6nqtPPz5vm
SIOfme2MPf03fUyIpOpjJQECQbIipU/pOqpv9yblmit1VLU65RvDfoRUAA/A0+gw
tBZ9MDMVbB0+U1kcvE0AAExxkjbyOI8BOOJtgsMG6/kjF1dCAQIWPfEDPKtWjhtG
VkiLC/EPYewL94+/H0oRAby5TrlEoHpwirJpDb4buoOJCAfNSrkluXrSiyw+zRr5
tfSZwj/SdZRCxMtggooUDc9PfTij0H1ADe2hhOYExEI8to2zAlv9uhqNbnbMMI2Y
KFTb8UXhtmx4ym+m13AacAMBzUfxqdkSJnHSgKGhgSy0KJ1dgfpWFfe4+0+egAMV
2k9Ww0Up0WqTbISJrAHL1p/f5kYUh73o7OTlgnXbGYa7KcMJB9o=
=JL9x
-----END PGP SIGNATURE-----

--HXBSxkbXXprPwElw--
