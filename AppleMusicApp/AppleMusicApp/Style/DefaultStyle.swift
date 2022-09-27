import UIKit

public enum DefaultStyle {
    public enum Colors {
        // UIColor 반환
        public static let tint: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor { traitCollection in
                    if traitCollection.userInterfaceStyle == .dark {
                        return .white   // dark 모드면 white를 tintColor로
                    } else {
                        return .black   // white 모드면 black을 tintColor로
                    }
                }
            } else {
                return .black   // iOS 이상이 아니라면 다크모드가 지원되지 않기에, black이 기본 tintColor로!
            }
        }()
    }
}
