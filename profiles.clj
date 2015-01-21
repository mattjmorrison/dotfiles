{:user {:dependencies [[slamhound "1.5.5"]
                       [pjstadig/humane-test-output "0.6.0"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :plugins [[lein-kibit "0.0.8"]
                  [com.jakemccrary/lein-test-refresh "0.5.5"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
