package config

case class FrontendConfig(
    xlen:    Int
)

case class Config(frontend: FrontendConfig)

object YuConfig {
    def apply(): Config = {
        val XLEN = 32
        Config (
            frontend = FrontendConfig(
                xlen = XLEN
            )
        )
        
    }
}
