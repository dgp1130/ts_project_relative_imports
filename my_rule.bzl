load("@build_bazel_rules_nodejs//:providers.bzl", "run_node")

def _my_rule_impl(ctx):
    run_node(
        ctx,
        executable = "_binary",
        arguments = [],
        inputs = [],
        outputs = [ctx.outputs.output],
    )

my_rule = rule(
    implementation = _my_rule_impl,
    attrs = {
        "output": attr.output(),
        "_binary": attr.label(
            default = "//:binary",
            executable = True,
            cfg = "exec",
        ),
    },
)
