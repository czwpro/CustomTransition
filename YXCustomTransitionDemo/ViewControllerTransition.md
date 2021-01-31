# 基础转场动画
 我们可以使用 `CATransition` 为 `UIViewController` 提供一些基础的视图转场动画。这些动画样式在 `CATransitionType` 定义，其中一些私有API并没有暴露出来。
 - 公有：fade、moveIn、push、reveal
 - 私有:
     - cube                   立方体效果
     - pageCurl               向上翻一页
     - pageUnCurl             向下翻一页
     - rippleEffect           水滴波动效果
     - suckEffect             变成小布块飞走的感觉
     - oglFlip                上下翻转
     - cameraIrisHollowClose  相机镜头关闭效果
     - cameraIrisHollowOpen   相机镜头打开效果

**下面的示例以 `Push` 和 `Present` 两种跳转方式实现：**，具体示例见项目中的 **`CATransition`**
```swift
// Push
@objc func pushSecond() {
    let controller = NavCATransitionSecondViewController()
    navigationController?.view.layer.add(pushAnimation(), forKey: nil)
    // 记得这里的 animated 要设为 false，不然会重复
    navigationController?.pushViewController(controller, animated: false)
}

func pushAnimation() -> CATransition {
    let transition = CATransition()
    transition.duration = 0.8
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

    // 下面四个是系统开放的API
    // moveIn, push, reveal, fade
    transition.type = .cube
    
    // 转场方向
    transition.subtype = .fromRight
    
    return transition
}

```
```swift
// Present
@objc func presentSecond() {
    let controller = ModalCATransitionSecondViewController()
    controller.modalPresentationStyle = .fullScreen
    view.window?.layer.add(presentAnimation(), forKey: nil)
    self.present(controller, animated: false, completion: nil)  //记得这里的 animated 要设为 false，不然会重复
}

func presentAnimation() -> CATransition {
    let transition = CATransition()
    transition.duration = 0.8
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
    
    // 下面四个是系统开放的API
    // moveIn, push, reveal, fade
    transition.type = .push
    
    // 转场方向
    transition.subtype = .fromRight
    
    return transition
}

```

# 基于 navigationController.pushViewController() 转场动画
`Cocoa` 框架提供了一些协议让我们可以自定义转场动画的行为。我们所要做的就是实现这些协议，下面是具体的步骤：
1. 在进行 `navigationController?.pushViewController(_:)` 之前设置 `navigationController?.delegate`即 `UINavigationControllerDelegate`, 此代理方法允许我们使用自定义视图转场动画类，其中包含了两个重要的方法：

    ```swift
    optional func navigationController(_ navigationController: UINavigationController, 
            animationControllerFor operation: UINavigationController.Operation, 
                              from fromVC: UIViewController, 
                                to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    ```
    此方法需要返回一个符合 `UIViewControllerAnimatedTransitioning` 协议自定义的视图过度动画器类，最终视图跳转要执行的动画表现在此类中实现。*（稍后会说明这个协议的具体实现）*

    
    ```swift
    optional func navigationController(_ navigationController: UINavigationController, 
              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    ```
    此方法允许视图控制器交互式的进行转场动画（也就是使用手势来控制动画），这里需要返回一个符合 `UIViewControllerInteractiveTransitioning` 协议的类，这个类将实现交互式动画的具体操作，系统已经为我们提供了一个实现此协议的类 `UIPercentDrivenInteractiveTransition`，我们只需要继承此类即可。

    
2. 在实现的 `UINavigationControllerDelegate` 协议的 `navigationController(_:animationControllerFor:from:to:)` 方法中需要放回一个具体实现动画的类，这个类符合 `UIViewControllerAnimatedTransitioning` 协议。 该协议主要方法如下：
    ```swift
    // 定义动画执行的时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval

    // 通过 `transitionContext` 可获取到视图相关信息然后进行动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    ```
    其中 `transitionDuration(using:)` 方法返回动画执行所需要的时间，`animateTransition(using:)` 方法带有一个符合 `UIViewControllerContextTransitioning` 协议的上下文对象，该对象让我们可以通过相关方法 得到当前视图控制器和将要跳转的视图控制器具体的信息。
    ```swift
    // 容器视图，用于存放视图控制器中的根视图，或者你也可以创建临时视图并放入其中，在不需要的时候移除即可
    var containerView: UIView { get }

    // 一个布尔值，指示是否应设置过渡动画。
    var isAnimated: Bool { get }

    // 一个布尔值，指示过渡当前是否是交互式的。
    var isInteractive: Bool { get } 
    
    // 返回一个布尔值，该值指示过渡是否已取消。
    var transitionWasCancelled: Bool { get }

    // 返回视图控制器过渡的表示样式。(仅在 present 的情况有效)
    var presentationStyle: UIModalPresentationStyle { get }

    /*
    一个符合 UIViewControllerInteractiveTransitioning 协议的交互控制器（在 UINavigationControllerDelegate，或者 UIViewControllerTransitioningDelegate 中被使用）,这下面这些方法中执行交互动画的更新、取消或完成。请注意，如果
    动画器是可中断的，那么调用 finishInteractiveTransition： 和 cancelInteractiveTransition： ，表示如果过渡不是
    再次中断，它将自然完成或被取消。
    */
    func updateInteractiveTransition(_ percentComplete: CGFloat)

    func finishInteractiveTransition()

    func cancelInteractiveTransition()

    // 如果过渡动画式可中断并正在暂停，则应调用此方法
    @available(iOS 10.0, *)
    func pauseInteractiveTransition()

    // 这个方法必须调用无论过渡是否完成还是被取消。
    func completeTransition(_ didComplete: Bool)

    // 获取指定 UITransitionContextViewControllerKey 的视图控制器对象
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController?

    // 获取指定 UITransitionContextViewKey 的视图对象（我们动画执行的视图对象就是充这里获取的）
    func view(forKey key: UITransitionContextViewKey) -> UIView?
    
    // 返回为过渡的视图应用仿射变换。
    var targetTransform: CGAffineTransform { get }
    
    // 此方法返回的矩形代表转换开始时相应视图的大小。对于已经在屏幕上的视图控制器，返回的 frame 通常与容器视图的框架矩形匹配。对于显示的视图控制器，此方法返回的值通常为 CGRectZero，因为视图尚未显示在屏幕上。
    func initialFrame(for vc: UIViewController) -> CGRect

    // 此方法返回的矩形表示转换结束时相应视图的大小。对于使用 present(_:) 跳转过程中涉及的视图，此方法返回的值可能是 CGRectZero，但也可能是有效的框架矩形。
    func finalFrame(for vc: UIViewController) -> CGRect
    ```
    
3. 最后通过将 `UIViewControlelr` 实现 `UINavigationControllerDelegate` 协议，并在协议对应的 `navigationController(_:animationControllerFor:from:to:)` 中返回一个实现 `UIViewControllerAnimatedTransitioning`  协议的对象，我们就可以完成一个自定义视图控制器的过渡动画效果。

# 基于 present() 跳转的转场动画
在基于 `navigationController?.pushViewController()`  的转场动画中，我们为当前的视图控制器的 `navigationController?.delegate` 设置了代理，并实现了符合 `UIViewControllerAnimatedTransitioning` 协议的类来 实现转场动画。在这里我们使用模态的方式 `present()` 来跳转页面，所以我们要为要跳转的视图控制器设置代理，例如：
```swift
class ModalBaseViewController: UIViewController {
    @objc func presentSecond() {
        let controller = ModalBaseSecondViewController()

        // 1.设置代理
        controller.transitioningDelegate = self

        self.present(controller, animated: true, completion: nil)
    }
}

```
```swift
extension ModalBaseViewController: UIViewControllerTransitioningDelegate {
    // present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }

    // dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }
}
```
同时与之前相同， `UIViewControllerTransitioningDelegate` 协议中也是通过返回一个符合 `UIViewControllerAnimatedTransitioning` 协议的类来实现最终的动画，甚至你可以使用相同的动画器对象来应用于两种方式的页面跳转 。


# 基于 navigationController.pushViewController() 可交互式转场动画
如果你希望常规的转场过渡动画变的更加有意思，你可以再加入交互式的操作。通过 `UINavigationControllerDelegate` 中的 `navigationController(_:interactionControllerFor:)` 方法返回一个符合 `UIViewControllerInteractiveTransitioning` 协议的类可以实现交互式动画操作。系统已经实现了一个符合该协议的类 `UIPercentDrivenInteractiveTransition`，我们可以通过继承此类实现交互式操作过程。下面是这个类中的`API`:
```swift
// 这个时间是 `transitionDuration:` 方法中返回的时间
var duration: CGFloat { get }

// 由 `updateInteractiveTransition` 指定的最后一个 `percentComplete` 值：
var percentComplete: CGFloat { get }

// completeSpeed 默认为1.0，对应于完成时间（1 - percentComplete）* duration。它必须大于0.0。实际上完成速度与完成速度 completionSpeed 成反比。可以设置在调用 cancelInteractiveTransition 或 finishInteractiveTransition 之前为了加快或减慢非互动部分过渡。
var completionSpeed: CGFloat

// 过渡的交互部分完成后，此属性可以设置为指示不同的动画曲线。默认为 UIViewAnimationCurveEaseInOut。请注意，在动画的交互部分期间，时序曲线是线性的。
var completionCurve: UIView.AnimationCurve

// 对于可中断的动画器，可以指定在继续过渡时要使用的其他时序曲线提供者。如果动画过渡对象没有出售可中断的动画器，则将忽略此属性。
var timingCurve: UITimingCurveProvider?

// 为了在非交互式过程中中断过渡可将此设置为 "NO"。默认情况下为YES，与10.0之前的行为一致。
var wantsInteractiveStart: Bool

// 用这个方法来暂停一个运行的可中断动画器。这将确保所有块
由过渡协调器的 notifyWhenInteractionChangesUsingBlock： 方法提供，并在当过渡移入和移出交互模式时执行。
func pause()

// 下面的这些方法应该在手势识别器中调用或者是在其它一些驱动交互的逻辑。这种风格的交互式控制器应该仅被用在一个动画器中，该动画器在 animateTransition：方法中实现一个 CA 风格的过渡效果。如果指定了这种类型的交互控制器, animateTransition: 方法必须确保调用 UIViewControllerTransitionParameters（这个类由系统提供，也就是符合了 UIViewControllerContextTransitioning 协议的对象） completeTransition: 方法。不应调用 UIViewControllerContextTransitioning 上的其他交互式方法。如果存在可中断的动画制作器，则这些方法将更新或继续向前或向后的过渡。
func update(_ percentComplete: CGFloat)

func cancel()

func finish()
```
具体的使用案例见项目中**Navigation-InteractiveTransition**部分


# 基于 present() 的可交互式转场动画
与 `navigationController.pushViewController()` 中的交互式动画类似，对于以 `present()` 方式跳转的交互式转场动画，我们需要在实现的 `UIViewControllerTransitioningDelegate` 代理中实现 `interactionControllerForPresentation(using:)` 或 `interactionControllerForDismissal(using:)` 方法，这两个方法分别返回 `present()` 和 `dismiss()` 的交互式操作对象，也就是符合 `UIViewControllerInteractiveTransitioning` 协议的类。此类的具体实现其实就跟 `navigationController.pushViewController()` 中实现相同。

具体的使用案例见项目中**Modal-InteractiveTransition**部分

# 总结
- 实现 `navigationController.pushViewController()` 转场动画步骤
    1. 设置 `navigationContorller.delegate`，并实现 `UINavigationControllerDelegate` 中的 `navigationController(_:animationControllerFor:from:to:)` 方法，在此方法中返回自定义的动画器类。
    2. 自定义实现符合 `UIViewControllerAnimatedTransitioning` 协议的动画器，实现 `transitionDuration(using:)` 和 `animateTransition(using:)` 方法来完成具体的动画。
    3. 对于交互式动画需要实现 `UINavigationControllerDelegate` 中的 `navigationController(_:interactionControllerFor:)` 方法，返回一个自定义的继承于 `UIPercentDrivenInteractiveTransition` 的类，在此类中实现具体的交互行为。
    
- 实现 `present()` 转场动画步骤
    1. 设置 `toController.transitioningDelegate`，并实现 `UIViewControllerTransitioningDelegate` 中的 `animationController(forPresented:presenting:source:)` 和 `animationController(forDismissed:)` 方法，在此方法中返回自定义的动画器类。
    2. 自定义实现符合 `UIViewControllerAnimatedTransitioning` 协议的动画器，实现 `transitionDuration(using:)` 和 `animateTransition(using:)` 方法来完成具体的动画。
    3. 对于交互式动画需要实现 `UIViewControllerTransitioningDelegate` 中的 `interactionControllerForPresentation(using:)` 和 `interactionControllerForDismissal(using:)` 方法，返回一个自定义的继承于 `UIPercentDrivenInteractiveTransition` 的类，在此类中实现具体的交互行为。
