local ls = require('luasnip')

local snip = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local insert = ls.insert_node

ls.add_snippets(nil, {
    yaml = {
        snip(
            {
                trig = "pod",
                namr = "k8s Pod",
                dscr = "Kubernetes Pod definition",
            },
            fmt(
                [[
                  apiVersion: v1
                  kind: Pod
                  metadata:
                    name: {}
                    labels:
                      {}: {}
                  spec:
                    containers:
                    - name: {}
                      image: {}:{}
                      ports:
                      - containerPort: {}
                ]],
                {
                    insert(1, "nginx"),
                    insert(2, "run"),
                    insert(3, "nginx"),
                    insert(4, "nginx"),
                    insert(5, "nginx"),
                    insert(6, "latest"),
                    insert(7, "80"),
                }
            )
        ),
    },
})
