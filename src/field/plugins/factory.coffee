module.exports = (classes) ->
  create: (options, test = (() -> true)) ->
    for clazz in classes
      if test(clazz) and clazz.test(options)
        clazz.create options
