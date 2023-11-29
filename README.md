![header](https://capsule-render.vercel.app/api?type=waving&color=ff6d1c&height=300&section=header&text=🎨내가그린기린그림%20&fontSize=90&fontColor=ffffff)

# 🖼️🦒🎨 내가 그린 기린 그림 🎨🦒🖼️
내일배움캠프 6주차 iOS 입문 팀과제 : SNS협업툴

#### 기간 : 2023/08/14 ~ 2023/08/20 (7일)
<br/>


## 어플 소개
누구나 쉽게 사용할 수 있는 SNS 어플을 만들어본다면 어떻게 될까? 라는 생각으로 시작된 프로젝트<br/>
어린이부터 어른까지 모두가 시각적으로 쉽게 사용할 수 있는 이미지 기반 SNS<br/>
어린 아이들도 사용할 수 있는만큰 댓글 기능은 막아둔 채 Emoji만으로 반응을 남길 수 있는 구조
<br/><br/>

## ⚡️에너자이(2)조⚡️ 팀 구성원
<table>
  <tbody>
    <tr>
     <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/chumubird">
       <img src="https://avatars.githubusercontent.com/u/138557882?v=4" width="100px;" alt="이동준"/>
       <br />
         <sub>
           <b>박철우</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
    <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/Madman-dev">
       <img src="https://avatars.githubusercontent.com/u/119504454?v=4" width="100px;" alt="박상우"/>
       <br />
         <sub>
           <b>이동준</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/doyeonyyy">
       <img src="https://avatars.githubusercontent.com/u/62759476?v=4" width="100px;" alt="남보경"/>
       <br />
         <sub>
           <b>김도연</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/BoKyeongee">
       <img src="https://avatars.githubusercontent.com/u/124825477?v=4" width="100px;" alt="정주연"/>
       <br />
         <sub>
           <b>남보경</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/kiakim01">
       <img src="https://avatars.githubusercontent.com/u/100465645?v=4" width="100px;" alt="최영군"/>
       <br />
         <sub>
           <b>김귀아</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
  </tbody>
</table>

<br/>

## 개발환경
### 주요 개발 기능
- CollectionView를 이용한 이미지 피드 구현
- UI TextView, UI TextField 등을 이용한 사용자 텍스트 입력 기능, 이미지 올리기
- StackView를 이용한 이미지와 텍스트를 포함한 포스트 세부내용 보여주기, 이미지 다운로드 및 공유 기능, 좋아요 이모지 등 시각적이고 직관적 피드백 기능
- TableView를 이용한 사용자 정보 보여주기
- UserDefault를 이용한 사용자 데이터 관리

### 화면구성/기능별 분담
- 메인페이지 : 박철우
- 디테일 페이지 : 이동준
- 글쓰기 페이지 : 김도연
- 마이페이지(프로필) : 남보경
- 프로필편집 페이지 : 김귀아

### Trouble shooting
- **ViewController instantiation 여부에 따라 재활용**<br/>
다른 탭 방문 이후 돌아올 경우, writing viewController이 온전히 내려지지 않는 경우가 간혹 발생,
이를 대비하고자 viewController 생성 유무에 따라 생성 혹은 재활용을 하고자 코드 작성

```swift
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        if let writingViewController = self.navigationController?.viewControllers.first(where: { $0 is WritingViewController }) as? WritingViewController {
            self.navigationController?.pushViewController(writingViewController, animated: true)
        }
        let writingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writingViewControllerID") as! WritingViewController
        self.navigationController?.pushViewController(writingViewController, animated: true)
    }
```

- **이미지 로드 이후 검수하는 단계에서 indexPath 오류 발생**<br/>
  Asset으로 보유하고 있던 이미지 파일 갯수를 넘거나 일정 단계를 넘으면 indexPath 오류가 발생하며 중단 되는 상황 확인<br/>
  → 데이터의 최소 단위만 검수하면서 데이터 Range를 명확하게 명시하지 않아 발생하는 이슈.
  ```swift
  if let selectedIndexPath = defaults.value(forKey: "current") as? Int {
            if selectedIndexPath >= 0 && selectedIndexPath < userData.postImgNames.count {
                let postImageName = userData.postImgNames[selectedIndexPath]
                let postTitle = userData.postTitles[selectedIndexPath]
                let postDate = userData.postDates[selectedIndexPath]
                let postContent = userData.postContents[selectedIndexPath]
                
                postedImage.image = UIImage(named: postImageName)
                detailBodyLabel.text = postContent
                detailDateLabel.text = postDate
                detailTitleLabel.text = postTitle
                pageControl.numberOfPages = postImageName.count
                pageControl.hidesForSinglePage = true
            } else {
                // 에러 처리 안되는 중...
                let errorHandler = ErrorHandler()
                errorHandler.displayError(for: .needtoReload)
            }
  }
  ```
- **이미지 Swipe 기능 추가**<br/>
  pageControl을 사용할 경우, 사용자가 직접 pageControl을 탭하지 않으면 다음 이미지를 확인하지 못하는 문제 확인<br/>
  → 좌우 UISwipeGestureRecognizer를 적용하여 이미지를 넘겨 볼 수 있도록 정리<br/>
  → 사용자가 화면에서 마주하는 이미지, 그림 영역을 맡은 postedImage UIComponent에도 사용자 인터렉션이 적용 될 수 있도록 코드 추가
  ```swift
  func enableSwipe() {
        postedImage.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeLeft.direction = .left
        postedImage.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeRight.direction = .right
        postedImage.addGestureRecognizer(swipeRight)
    }
  ```
  
- **PageControl이 이미지와 연결되지 않는 문제**<br/>
  정상 작동하다가 Swipe 기능을 적용하면서 page control이 움직이지 않는 문제점 발견<br/>
  → 프로젝트 기간 이슈로 인해 중단

