(defmodule mutex-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest start
  (let ((sem (mutex:start)))
    (is-equal 'ok (mutex:wait sem))
    (is-equal 'ok (mutex:signal sem))
    (is-equal 'ok (mutex:wait sem))))

(deftest robust
  (let ((sem (mutex:start))
        (parent (self)))
    (let ((crasher (spawn (lambda ()
                            (mutex:wait sem)
                            (! parent 'go)
                            (exit 'crash) ;; (receive ('go 'ok))
                            )))))
    (receive ('go 'ok))
    (is-equal 'ok (mutex:wait sem))))