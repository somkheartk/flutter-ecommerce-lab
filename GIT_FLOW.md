# Git Flow Strategy - Flutter eCommerce Lab

## 🌳 Branch Structure

ตามมาตรฐาน Git Flow เราได้สร้าง branch structure ดังนี้:

### 📋 Main Branches

#### 🏠 `main` (Production Branch)
- **วัตถุประสงค์**: เก็บโค้ดที่พร้อม production และได้รับการทดสอบแล้ว
- **การใช้งาน**: Deploy ขึ้น production server
- **ข้อจำกัด**: ห้าม commit โดยตรง ใช้ merge จาก release หรือ hotfix เท่านั้น

#### 🔧 `develop` (Development Branch)  
- **วัตถุประสงค์**: integration branch สำหรับ features ต่างๆ
- **การใช้งาน**: รวม features ที่พัฒนาเสร็จแล้ว
- **การทำงาน**: merge จาก feature branches

### 🚀 Supporting Branches

#### ⭐ Feature Branches
**รูปแบบ**: `feature/[feature-name]`

**ตัวอย่าง**:
- `feature/thai-documentation` - เพิ่มเอกสารภาษาไทย
- `feature/payment-integration` - ระบบการชำระเงิน  
- `feature/user-profile` - หน้าโปรไฟล์ผู้ใช้

**วิธีใช้**:
```bash
# สร้าง feature branch จาก develop
git checkout develop
git checkout -b feature/new-feature

# พัฒนาและ commit
git add .
git commit -m "feat: implement new feature"

# Push ขึ้น remote
git push -u origin feature/new-feature

# เมื่อเสร็จแล้วสร้าง Pull Request ไปยัง develop
```

#### 🎯 Release Branches
**รูปแบบ**: `release/v[version]`

**ตัวอย่าง**:
- `release/v1.0.0` - รุ่นแรก
- `release/v1.1.0` - เพิ่มฟีเจอร์ใหม่
- `release/v1.0.1` - แก้บัค

**วิธีใช้**:
```bash
# สร้าง release branch จาก develop
git checkout develop  
git checkout -b release/v1.0.0

# แก้ไขเล็กน้อย อัพเดต version
git commit -m "chore: bump version to 1.0.0"

# Push ขึ้น remote
git push -u origin release/v1.0.0

# เมื่อพร้อม merge ไปยัง main และ develop
```

#### 🚨 Hotfix Branches
**รูปแบบ**: `hotfix/[issue-name]`

**ตัวอย่าง**:
- `hotfix/login-crash` - แก้ปัญหาแอปหลุด
- `hotfix/payment-error` - แก้ข้อผิดพลาดการชำระเงิน

**วิธีใช้**:
```bash
# สร้าง hotfix จาก main (เร่งด่วน)
git checkout main
git checkout -b hotfix/critical-bug

# แก้ไขและ commit
git commit -m "fix: resolve critical bug"

# Push และ merge ไปยัง main และ develop
```

## 🔄 Git Flow Workflow

### 1. การพัฒนา Feature ใหม่
```bash
# 1. Update develop branch
git checkout develop
git pull origin develop

# 2. สร้าง feature branch
git checkout -b feature/awesome-feature

# 3. พัฒนาและ commit
git add .
git commit -m "feat: add awesome feature"

# 4. Push feature branch
git push -u origin feature/awesome-feature

# 5. สร้าง Pull Request: feature/awesome-feature → develop
```

### 2. การเตรียม Release
```bash
# 1. Update develop
git checkout develop
git pull origin develop

# 2. สร้าง release branch
git checkout -b release/v1.1.0

# 3. อัพเดต version และแก้ไขเล็กน้อย
echo "version: 1.1.0+2" > pubspec.yaml
git commit -m "chore: bump version to 1.1.0"

# 4. Push release branch
git push -u origin release/v1.1.0

# 5. สร้าง Pull Request: release/v1.1.0 → main
# 6. หลัง merge แล้วสร้าง Pull Request: main → develop
```

### 3. การแก้ไขเร่งด่วน (Hotfix)
```bash
# 1. Update main branch
git checkout main
git pull origin main

# 2. สร้าง hotfix branch
git checkout -b hotfix/urgent-fix

# 3. แก้ไขและ commit
git commit -m "fix: resolve urgent issue"

# 4. Push hotfix
git push -u origin hotfix/urgent-fix

# 5. สร้าง Pull Request: hotfix/urgent-fix → main
# 6. สร้าง Pull Request: hotfix/urgent-fix → develop
```

## 📝 Commit Message Convention

ใช้ [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types:
- `feat`: ฟีเจอร์ใหม่
- `fix`: แก้บัค
- `docs`: เอกสาร
- `style`: การจัดรูปแบบโค้ด
- `refactor`: ปรับปรุงโค้ด
- `test`: เพิ่มหรือแก้ไขการทดสอบ
- `chore`: งานบำรุงรักษา

### ตัวอย่าง:
```bash
feat: add Thai language support
fix: resolve shopping cart calculation bug
docs: update API documentation
style: format code with prettier
refactor: optimize product loading performance
test: add unit tests for cart provider
chore: update dependencies to latest versions
```

## 🛡️ Branch Protection Rules

### Main Branch Protection:
- ✅ Require pull request reviews
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Restrict pushes that create files larger than 100MB
- ❌ Allow force pushes
- ❌ Allow deletions

### Develop Branch Protection:
- ✅ Require pull request reviews
- ✅ Require status checks to pass
- ✅ Allow force pushes (for maintainers only)

## 🚀 Current Branches Status

### ✅ Active Branches:
- `main` - Production ready code
- `develop` - Development integration
- `feature/thai-documentation` - Thai docs & widget guide
- `release/v1.0.0` - First release preparation

### 📋 Branch Commands:
```bash
# ดู branches ทั้งหมด
git branch -a

# สลับ branch
git checkout <branch-name>

# สร้าง branch ใหม่
git checkout -b <new-branch-name>

# ลบ branch local
git branch -d <branch-name>

# ลบ branch remote
git push origin --delete <branch-name>
```

## 📚 Resources

- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

---

📝 **หมายเหตุ**: Git Flow นี้ถูกออกแบบมาสำหรับโปรเจคที่มีทีมพัฒนาหลายคน และต้องการความเสถียรในการ release