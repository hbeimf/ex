# ExUseErs

**TODO: Add description**

# SlotByEx

**TODO: Add description**

1,
$ mix new --umbrella ex_use_ers

2,
添加到依赖 ./config.exs
{:distillery, "~> 1.5.2", runtime: false}

$ make release_init


3, 修改发布文件 ./rel/config.exs

# 在本配置文件里增加下面两段 ：
environment :master do
  set include_erts: false
  set include_src: false
  set cookie: :"{a!`N)!~,w%{6$[?=4_q^wF)tXL(DVGut[CD!d]Q)<f6*6IjMfaq(>)S?D<uv!y9"
  set vm_args: "config/vm_master.args"
end

environment :slave do
  set include_erts: false
  set include_src: false
  set cookie: :"{a!`N)!~,w%{6$[?=4_q^wF)tXL(DVGut[CD!d]Q)<f6*6IjMfaq(>)S?D<uv!y9"
  set vm_args: "config/vm_slave.args"
end

增加  config/vm_master.args


4,  
增加app
cd apps
$ mix new ers --sup

