load("github.com/SonarSource/cirrus-modules@5cd6425fdb78665f07284f2c12d495618a7bbc0a", "load_features") # 3.1.0

def main(ctx):
    return load_features(ctx, only_if=dict(), aws=dict(env_type="dev", cluster_name="CirrusCI-10-dev"))
