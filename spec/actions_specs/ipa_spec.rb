describe Fastlane do
  describe Fastlane::FastFile do
    describe "IPA Integration" do

      it "works with default setting" do
        result = Fastlane::FastFile.new.parse("lane :test do 
          ipa
        end").runner.execute(:test)

        expect(result).to eq([])
      end

      it "works with array of arguments" do

        result = Fastlane::FastFile.new.parse("lane :test do 
          ipa '-s TestScheme', '-w Test.xcworkspace'
        end").runner.execute(:test)

        expect(result).to eq(['-s TestScheme', '-w Test.xcworkspace'])
      end

      it "works with object argument without clean and archive and verbose" do

        result = Fastlane::FastFile.new.parse("lane :test do 
          ipa ({
            workspace: 'Test.xcworkspace',
            project: nil,
            configuration: 'Release',
            scheme: 'TestScheme',
            destination: nil,
            embed: nil,
            identity: nil,
            ipa: 'JoshIsAwesome.ipa'
          })
        end").runner.execute(:test)

        expect(result.size).to eq(4)
      end

      it "works with object argument with clean and archive and verbose" do

        result = Fastlane::FastFile.new.parse("lane :test do 
          ipa ({
            workspace: 'Test.xcworkspace',
            project: nil,
            configuration: 'Release',
            scheme: 'TestScheme',
            clean: nil,
            archive: nil,
            destination: nil,
            embed: nil,
            identity: nil,
            ipa: 'JoshIsAwesome.ipa',
            verbose: nil
          })
        end").runner.execute(:test)

        expect(result.size).to eq(7)
      end

      it "works with object argument with all" do

        result = Fastlane::FastFile.new.parse("lane :test do 
          ipa ({
            workspace: 'Test.xcworkspace',
            project: 'Test.xcproject',
            configuration: 'Release',
            scheme: 'TestScheme',
            clean: nil,
            archive: nil,
            destination: 'Nowhere',
            embed: 'Sure',
            identity: 'bourne',
            sdk: '10.0',
            ipa: 'JoshIsAwesome.ipa',
            xcconfig: 'ExtraConfig.xcconfig',
            verbose: nil
          })
        end").runner.execute(:test)

        expect(result.size).to eq(13)
        expect(result).to include('-w "Test.xcworkspace"')
        expect(result).to include('-p "Test.xcproject"')
        expect(result).to include('-c "Release"')
        expect(result).to include('-s "TestScheme"')
        expect(result).to include('--clean')
        expect(result).to include('--archive')
        expect(result).to include('-d "Nowhere"')
        expect(result).to include('-m "Sure"')
        expect(result).to include('-i "bourne"')
        expect(result).to include('--sdk "10.0"')
        expect(result).to include('--ipa "JoshIsAwesome.ipa"')
        expect(result).to include('--xcconfig "ExtraConfig.xcconfig"')
        expect(result).to include('--verbose')
      end

      it "works with object argument with all and extras" do

        result = Fastlane::FastFile.new.parse("lane :test do 
          ipa ({
            workspace: 'Test.xcworkspace',
            project: 'Test.xcproject',
            configuration: 'Release',
            scheme: 'TestScheme',
            clean: nil,
            archive: nil,
            destination: 'Nowhere',
            embed: 'Sure',
            identity: 'bourne',
            sdk: '10.0',
            ipa: 'JoshIsAwesome.ipa',
            xcconfig: 'ExtraConfig.xcconfig',
            verbose: nil,
            hehehe: 'hahah'
          })
        end").runner.execute(:test)

        expect(result.size).to eq(13)
      end

    end
  end
end
