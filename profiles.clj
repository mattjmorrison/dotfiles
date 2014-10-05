{:user {:plugins [[lein-kibit "0.0.8"]
                  [lein-midje "3.1.3"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}}}
