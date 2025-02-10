from schema import Schema, Optional, Or

config_schema = Schema({
    "clusters": [
        {
            Optional("project"): str,
            Optional("stage"): str,
            Optional("ssoGroup", default="sso:call-me@lajko.dev"): str,


            "nodePools": [
                {
                    Optional("name"): str,
                    Optional("availability_zones", default=["eu01-2"]): list,
                    Optional("machine_type", default="c1.2"): str,
                    Optional("os_version_min", default="4081.2.0"): str,
                    Optional("maximum", default=2): int,
                    Optional("minimum", default=1): int,
                    Optional("taints"): [dict],
                    Optional("labels"): dict,
                }
            ],

        },

    ]
})
