module Tmp where

import Data.Aeson

aesonOpts :: Options
aesonOpts =
    defaultOptions
        { sumEncoding = ObjectWithSingleField
        }
