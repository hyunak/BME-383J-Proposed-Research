function PCA(data)
    features = data(:,1:5);
    [coeff, score, latent] = pca(features); % pca function
    % Scree plot
    subplot(3,2,5)
    plot(latent,'-o');
    title('Scree Plot');
    xlabel('Principal Component Number');
    ylabel('Eigenvalue');
    % get ir1
    mid = repmat(mean(features),[size(features,1) 1]);
    ir1 = mid + score(:,1) * coeff(:,1)';
    % plot ir1
    figure();
    plot(ir1);
    title('ir1')
end